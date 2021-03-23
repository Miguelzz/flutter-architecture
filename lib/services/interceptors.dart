import 'package:group/database/initialize-cache.dart';
import 'package:group/models/assets.dart';
import 'package:group/models/factories.dart';
import 'package:group/database/database.dart';
import 'package:group/services/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'list_services.dart';

class HttpCache<T> {
  final ValueGetter<Stream<T?>> api;
  final ValueGetter<Stream<T?>> cache;
  HttpCache(this.api, this.cache);
}

class ServiceCache {
  ServiceCache._internal();
  static ServiceCache _singleton = ServiceCache._internal();
  static ServiceCache get instance => _singleton;
  final cache = AppDatabase.instance;
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
          handler.next(options..headers = {'token': await cache.getToken()});
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

  HttpCache<T?> get<T extends Entity>(UrlCache<T> point,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) {
    if (factories[T.toString()] == null) {
      print('\n\n***********************');
      print('ERROR FACTORIA NO EXISTE ${T.toString()}');
      print('***********************\n\n');
    }

    final entity = factories[T.toString()]!();

    return HttpCache(() async* {
      try {
        if (InitializeCache.instance.useMock) {
          yield point.mock;
        } else if (ConnetivityService.instance.connection) {
          final http = interceptor(point.base);
          final info = await http.get(
            point.url,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            options: options,
          );
          yield entity.fromJson(info.data);
        }
      } catch (e) {
        print(e);
      }
    }, () async* {
      try {
        if (point.cache != null) {
          yield entity.fromJson(await cache.getDB(point.cache!));
        }

        if (InitializeCache.instance.useMock) {
          yield point.mock;
        } else if (ConnetivityService.instance.connection) {
          final http = interceptor(point.base);
          final info = await http.get(
            point.url,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            options: options,
          );
          if (point.cache != null) {
            cache.setDB(
                point.cache!, entity.fromJson(info.data)?.toJson() ?? {});
          }
          yield entity.fromJson(info.data);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  HttpCache<T?> post<T>(UrlCache<T> point,
      {dynamic? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) {
    if (factories[T.toString()] == null) {
      print('\n\n***********************');
      print('ERROR FACTORIA NO EXISTE ${T.toString()}');
      print('***********************\n\n');
    }
    final entity = factories['User']!();

    return HttpCache(() async* {
      try {
        if (InitializeCache.instance.useMock) {
          yield point.mock;
        } else if (ConnetivityService.instance.connection) {
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
          yield entity.fromJson(info.data);
        }
      } catch (e) {
        print(e);
      }
    }, () async* {
      try {
        if (point.cache != null) {
          yield entity.fromJson(await cache.getDB(point.cache!));
        }
        if (InitializeCache.instance.useMock) {
          yield point.mock;
        } else if (ConnetivityService.instance.connection) {
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

          if (point.cache != null) {
            cache.setDB(
                point.cache!, entity.fromJson(info.data)?.toJson() ?? {});
          }
          yield entity.fromJson(info.data);
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
