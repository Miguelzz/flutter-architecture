import 'package:get/get.dart';
import 'package:group/app/data/database/app-cache.dart';
import 'package:group/app/data/models/factories.dart';
import 'package:group/app/data/database/database.dart';
import 'list_services.dart';
import 'package:dio/dio.dart';
import 'dart:async';

enum TypeData { NATIVES, ENTITIES, LIST_NATIVES, LIST_ENTITIES }

class ServiceCache {
  static final AppDatabase _db = Get.find<AppDatabase>();
  ServiceCache._internal();
  static ServiceCache _singleton = ServiceCache._internal();
  static ServiceCache get instance => _singleton;

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
          print('onResponse');
          handler.next(response);
        },
        onError: (error, handler) async {
          print('onError');
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

    if (point.cache == TypeCache.TEMPORARY ||
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

    if (AppCache.useMock) {
      yield point.mock;
    } else if (AppCache.connection) {
      final http = interceptor(point.base);
      final info = await http.get(
        point.url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
      );
      if (point.cache == TypeCache.PERSISTENT ||
          point.cache == TypeCache.TEMPORARY) {
        if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
          _db.setTemporary(point.url, info.data);
        } else if (type == TypeData.ENTITIES) {
          _db.setTemporary(point.url,
              factories[T.toString()]!().fromJson(info.data)?.toJson() ?? {});
        } else if (type == TypeData.LIST_ENTITIES) {
          _db.setTemporary(
              point.url,
              info.data
                  .map((x) =>
                      factories[T.toString()]!().fromJson(x)?.toJson() ?? {})
                  .toList());
        }
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

    if (point.cache == TypeCache.TEMPORARY ||
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

    if (AppCache.useMock) {
      yield point.mock;
    } else if (AppCache.connection) {
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

      if (point.cache == TypeCache.PERSISTENT ||
          point.cache == TypeCache.TEMPORARY) {
        if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
          _db.setTemporary(point.url, info.data);
        } else if (type == TypeData.ENTITIES) {
          _db.setTemporary(point.url,
              factories[T.toString()]!().fromJson(info.data)?.toJson() ?? {});
        } else if (type == TypeData.LIST_ENTITIES) {
          _db.setTemporary(
              point.url,
              info.data
                  .map((x) =>
                      factories[T.toString()]!().fromJson(x)?.toJson() ?? {})
                  .toList());
        }
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
