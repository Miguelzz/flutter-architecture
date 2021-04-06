import 'package:get/get.dart';
import 'package:group/app/data/database/app-cache.dart';
import 'package:group/app/data/models/factories.dart';
import 'package:group/app/data/database/database.dart';
import 'list_services.dart';
import 'package:dio/dio.dart';
import 'dart:async';

enum TypeData { NATIVES, ENTITIES, LISTS }

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
    if (RegExp(r'^List<[a-zA-Z0-9]+>$').hasMatch(entity)) return TypeData.LISTS;
    if (factories[entity] != null) return TypeData.ENTITIES;
    throw ('ERROR FACTORIA NO EXISTE $entity');
  }

  Stream<T?> get<T>(UrlCache<T> point,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async* {
    final entity = factories[T.toString()]!();
    var type = _isEntity(T.toString());

    if (point.cache == TypeCache.TEMPORARY ||
        point.cache == TypeCache.PERSISTENT) {
      if (type == TypeData.ENTITIES) {
        yield entity.fromJson(await _db.getKey(point.url)) as T?;
      } else {
        yield await _db.getKey(point.url) as T?;
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
        if (type == TypeData.ENTITIES) {
          _db.setTemporary(
              point.url, entity.fromJson(info.data)?.toJson() ?? {});
        } else {
          _db.setTemporary(point.url, info.data);
        }
      }
      if (type == TypeData.ENTITIES) {
        yield entity.fromJson(info.data) as T?;
      } else {
        yield info.data as T?;
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
    print('HOLA 3');
    final entity = factories[T.toString()]!();
    var type = _isEntity(T.toString());

    if (point.cache == TypeCache.TEMPORARY ||
        point.cache == TypeCache.PERSISTENT) {
      if (type == TypeData.ENTITIES) {
        yield entity.fromJson(await _db.getKey(point.url)) as T?;
      } else {
        yield await _db.getKey(point.url) as T?;
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
        if (type == TypeData.ENTITIES) {
          _db.setTemporary(
              point.url, entity.fromJson(info.data)?.toJson() ?? {});
        } else {
          _db.setTemporary(point.url, info.data);
        }
      }
      if (type == TypeData.ENTITIES) {
        yield entity.fromJson(info.data) as T?;
      } else {
        yield info.data as T?;
      }
    }
  }
}
