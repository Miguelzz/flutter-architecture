import 'package:group/database/initialize-cache.dart';
import 'package:group/models/factories.dart';
import 'package:group/services/manager.dart';
import 'package:group/database/database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'list_services.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier? requestRetrier;

  RetryOnConnectionChangeInterceptor({
    @required this.requestRetrier,
  });
}

class DioConnectivityRequestRetrier {
  final Dio dio = Dio();
  final Connectivity connectivity = Connectivity();

  DioConnectivityRequestRetrier();

  Future<void> scheduleRequestRetry(RequestOptions requestOptions) async {
    connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          // Ensure that only one retry happens per connectivity change by cancelling the listener
          //streamSubscription.cancel();
          // Copy & paste the failed request's data into the new request
          dio.request(
            requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            //options: requestOptions,
          );
        }
      },
    );
  }
}

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

  final Dio http = Dio(BaseOptions(
    headers: {
      "Accept": "application/json",
      'token': InitializeCache.instance.token
    },
    responseType: ResponseType.json,
    //receiveTimeout: 15000,
    //connectTimeout: 10000,
    followRedirects: false,
    receiveDataWhenStatusError: true,
  ));
  // ..interceptors.add(
  //   RetryOnConnectionChangeInterceptor(
  //     requestRetrier: DioConnectivityRequestRetrier(),
  //   ),
  // );

  HttpCache<T?> get<T>(UrlCache<T> point,
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
        if (!InitializeCache.instance.useMock &&
            ManagerService.instance.connection) {
          final info = await http.get(
            point.urlFull(),
            queryParameters: queryParameters,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            options: options,
          );
          yield entity.fromJson(info.data);
        } else if (InitializeCache.instance.useMock) {
          yield point.mock;
        }
      } catch (e) {
        print(e);
      }
    }, () async* {
      try {
        if (point.cache != null) {
          yield entity.fromJson(await cache.getDB(point.cache!));
        }

        if (!InitializeCache.instance.useMock &&
            ManagerService.instance.connection) {
          final info = await http.get(
            point.urlFull(),
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
        } else if (InitializeCache.instance.useMock) {
          yield point.mock;
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
        if (!InitializeCache.instance.useMock &&
            ManagerService.instance.connection) {
          final info = await http.post(
            point.urlFull(),
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onReceiveProgress,
          );
          yield entity.fromJson(info.data);
        } else if (InitializeCache.instance.useMock) {
          yield point.mock;
        }
      } catch (e) {
        print(e);
      }
    }, () async* {
      try {
        if (point.cache != null) {
          yield entity.fromJson(await cache.getDB(point.cache!));
        }
        if (!InitializeCache.instance.useMock &&
            ManagerService.instance.connection) {
          final info = await http.post(
            point.urlFull(),
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
        } else if (InitializeCache.instance.useMock) {
          yield point.mock;
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
