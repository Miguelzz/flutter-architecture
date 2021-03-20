import 'package:myArchitecture/models/factories.dart';
import 'package:myArchitecture/services/manager.dart';
import 'package:myArchitecture/database/database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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
  final ValueGetter<Future<T>> api;
  final ValueGetter<Future<T>> cache;
  HttpCache(this.api, this.cache);
}

class ServiceCache {
  ServiceCache._internal();
  static ServiceCache _singleton = ServiceCache._internal();
  static ServiceCache get instance => _singleton;
  final cache = AppDatabase.instance;

  final Dio http = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    headers: {"Accept": "application/json"},
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

  HttpCache<T> get<T>(String key, String url,
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

    return HttpCache(() async {
      if (ManagerService.instance.connection) {
        try {
          final info = await http.get(
            url,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            options: options,
          );
          return entity.fromJson(info.data);
        } catch (e) {
          print(e);
        }
      }
      return entity;
    }, () async {
      if (ManagerService.instance.connection) {
        try {
          final info = await http.get(
            url,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            options: options,
          );
          await cache.setDB(key, info.data);
        } catch (e) {
          print(e);
        }
      }

      return entity.fromJson(await cache.getDB(key));
    });
  }

  HttpCache<T> post<T>(String key, String url,
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

    return HttpCache(() async {
      if (ManagerService.instance.connection) {
        try {
          final info = await http.post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onReceiveProgress,
          );
          return entity.fromJson(info.data);
        } catch (e) {
          print(e);
        }
      }
      return entity;
    }, () async {
      if (ManagerService.instance.connection) {
        try {
          final info = await http.post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onReceiveProgress,
          );
          await cache.setDB(key, info.data);
        } catch (e) {
          print(e);
        }
      }
      return entity.fromJson(await cache.getDB(key));
    });
  }
}
