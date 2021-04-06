import 'package:get/get.dart';
import 'package:group/app/data/database/app-cache.dart';
import 'package:group/app/data/models/factories.dart';
import 'package:group/app/data/database/database.dart';
import 'package:dio/dio.dart';
import 'dart:async';

enum TypeData { NATIVES, ENTITIES, LIST_NATIVES, LIST_ENTITIES }

enum TypeCache { PERSISTENT, TEMPORARY, INTERNET }

class UrlCache<T> {
  final String url;
  final String base;
  final TypeCache? cache;
  final T? mock;

  UrlCache({required this.url, required this.base, this.cache, this.mock});
}

class Recent {
  final DateTime date;
  final String url;
  final String body;

  Recent(this.date, this.url, this.body);
}

class ServiceCache {
  static final AppDatabase _db = Get.find<AppDatabase>();

  static List<Recent> recentPost = [];
  static List<Recent> recentGet = [];

  final Dio _dio = Dio(
    BaseOptions(
      //receiveTimeout: 5000,
      //connectTimeout: 3000,
      followRedirects: false,
      receiveDataWhenStatusError: true,
    ),
  );

  Dio interceptor(String baseUrl) {
    _dio.interceptors.clear();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print('interceptor');
          handler.next(options..headers = {'token': await _db.getToken()});
        },
        onResponse: (response, handler) {
          print('onResponse $response');
          handler.next(response);
        },
        onError: (error, handler) async {
          print('onError $error');
          if (error.response?.statusCode == 403) {
            _dio.interceptors.requestLock.lock();
            _dio.interceptors.responseLock.lock();
            //RequestOptions options = error.response?.request;
            // FirebaseUser user = await FirebaseAuth.instance.currentUser();
            // token = await user.getIdToken(refresh: true);
            // await writeAuthKey(token);
            // options.headers["Authorization"] = "Bearer " + token;

            // _dio.interceptors.requestLock.unlock();
            // _dio.interceptors.responseLock.unlock();
            // return _dio.request(options.path, options: options);
            handler.next(error);
          }
        },
      ),
    );
    _dio.options.baseUrl = baseUrl;
    return _dio;
  }

  TypeData _isEntity(String entity) {
    final isNative = 'bool' == entity ||
        'int' == entity ||
        'num' == entity ||
        'double' == entity ||
        'String' == entity;

    if (isNative) return TypeData.NATIVES;
    if (RegExp(r'^List<[a-zA-Z0-9]+>$').hasMatch(entity)) {
      final matches = RegExp(r"List<(\w+)>").allMatches(entity);
      final name = matches.toList()[0].group(1);
      final type = _isEntity(name ?? '');

      if (type == TypeData.ENTITIES) {
        return TypeData.LIST_ENTITIES;
      }

      if (type == TypeData.NATIVES) {
        return TypeData.LIST_ENTITIES;
      }
    }
    if (factories[entity] != null) return TypeData.ENTITIES;
    throw ('ERROR FACTORIA NO EXISTE $entity');
  }

  Stream<T?> get<T>(UrlCache<T> point,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async* {
    var type = _isEntity(T.toString());
    bool recentQuery = false;
    try {
      recentGet.firstWhere((x) => x.url == point.url);
      recentQuery = true;
    } catch (e) {
      recentGet.add(Recent(DateTime.now(), point.url, ''));
    }

    if (AppCache.useMock) {
      yield point.mock;
    } else if (point.cache == TypeCache.TEMPORARY ||
        point.cache == TypeCache.PERSISTENT) {
      if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
        yield await _db.getKey(point.url) as T?;
      } else if (type == TypeData.ENTITIES) {
        yield factories[T.toString()]!().fromJson(await _db.getKey(point.url))
            as T?;
      } else if (type == TypeData.LIST_ENTITIES) {
        final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
        final name = matches.toList()[0].group(1);
        yield (await _db.getKey(point.url))
            .map((x) => factories[name]!().fromJson(x))
            .toList() as T?;
      }
    }
    if (!AppCache.useMock && AppCache.connection && !recentQuery) {
      final http = interceptor(point.base);
      final info = await http.get(
        point.url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
      );

      if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
        if (point.cache == TypeCache.PERSISTENT)
          _db.setPersist(point.url, info.data);
        else if (point.cache == TypeCache.TEMPORARY)
          _db.setTemporary(point.url, info.data);
      } else if (type == TypeData.ENTITIES) {
        if (point.cache == TypeCache.PERSISTENT)
          _db.setPersist(point.url,
              factories[T.toString()]!().fromJson(info.data)?.toJson() ?? {});
        else if (point.cache == TypeCache.TEMPORARY)
          _db.setTemporary(point.url,
              factories[T.toString()]!().fromJson(info.data)?.toJson() ?? {});
      } else if (type == TypeData.LIST_ENTITIES) {
        if (point.cache == TypeCache.PERSISTENT)
          _db.setPersist(
              point.url,
              info.data
                  .map((x) =>
                      factories[T.toString()]!().fromJson(x)?.toJson() ?? {})
                  .toList());
        else if (point.cache == TypeCache.TEMPORARY)
          _db.setTemporary(
              point.url,
              info.data
                  .map((x) =>
                      factories[T.toString()]!().fromJson(x)?.toJson() ?? {})
                  .toList());
      }

      if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
        yield info.data as T?;
      } else if (type == TypeData.ENTITIES) {
        yield factories[T.toString()]!().fromJson(info.data) as T?;
      } else if (type == TypeData.LIST_ENTITIES) {
        final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
        final name = matches.toList()[0].group(1);
        yield info.data.map((x) => factories[name]!().fromJson(x)).toList()
            as T?;
      }
    }
  }

  Stream<T?> post<T>(UrlCache<T> point,
      {dynamic? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async* {
    var type = _isEntity(T.toString());

    bool recentQuery = false;
    try {
      recentPost.firstWhere((x) => x.url == point.url);
      recentQuery = true;
    } catch (e) {
      recentPost.add(Recent(DateTime.now(), point.url, data.toString()));
    }

    if (AppCache.useMock) {
      yield point.mock;
    } else if (point.cache == TypeCache.TEMPORARY ||
        point.cache == TypeCache.PERSISTENT) {
      if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
        yield await _db.getKey(point.url) as T?;
      } else if (type == TypeData.ENTITIES) {
        yield factories[T.toString()]!().fromJson(await _db.getKey(point.url))
            as T?;
      } else if (type == TypeData.LIST_ENTITIES) {
        final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
        final name = matches.toList()[0].group(1);
        yield (await _db.getKey(point.url))
            .map((x) => factories[name]!().fromJson(x))
            .toList() as T?;
      }
    }
    if (!AppCache.useMock && AppCache.connection && !recentQuery) {
      final http = interceptor(point.base);
      final info = await http.post(
        point.url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onReceiveProgress,
      );

      if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
        if (point.cache == TypeCache.PERSISTENT)
          _db.setPersist(point.url, info.data);
        else if (point.cache == TypeCache.TEMPORARY)
          _db.setTemporary(point.url, info.data);
      } else if (type == TypeData.ENTITIES) {
        if (point.cache == TypeCache.PERSISTENT)
          _db.setPersist(point.url,
              factories[T.toString()]!().fromJson(info.data)?.toJson() ?? {});
        else if (point.cache == TypeCache.TEMPORARY)
          _db.setTemporary(point.url,
              factories[T.toString()]!().fromJson(info.data)?.toJson() ?? {});
      } else if (type == TypeData.LIST_ENTITIES) {
        if (point.cache == TypeCache.PERSISTENT)
          _db.setPersist(
              point.url,
              info.data
                  .map((x) =>
                      factories[T.toString()]!().fromJson(x)?.toJson() ?? {})
                  .toList());
        else if (point.cache == TypeCache.TEMPORARY)
          _db.setTemporary(
              point.url,
              info.data
                  .map((x) =>
                      factories[T.toString()]!().fromJson(x)?.toJson() ?? {})
                  .toList());
      }

      if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
        yield info.data as T?;
      } else if (type == TypeData.ENTITIES) {
        yield factories[T.toString()]!().fromJson(info.data) as T?;
      } else if (type == TypeData.LIST_ENTITIES) {
        final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
        final name = matches.toList()[0].group(1);
        yield info.data.map((x) => factories[name]!().fromJson(x)).toList()
            as T?;
      }
    }
  }
}
