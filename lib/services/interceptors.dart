import 'package:myArchitecture/services/manager.dart';
import 'package:myArchitecture/database/database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier? requestRetrier;

  RetryOnConnectionChangeInterceptor({
    @required this.requestRetrier,
  });

  @override
  Future onError(DioError err) async {
    if (_shouldRetry(err)) {
      try {
        await requestRetrier?.scheduleRequestRetry(err.request);
      } catch (e) {
        // Let any new error from the retrier pass through
        return e;
      }
    }
    // Let the error pass through if it's not the error we're looking for
    return err;
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT &&
        err.error != null &&
        err.error is SocketException;
  }
}

class DioConnectivityRequestRetrier {
  final Dio dio = Dio();
  final Connectivity connectivity = Connectivity();

  DioConnectivityRequestRetrier();

  Future<void> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription streamSubscription;

    streamSubscription = connectivity.onConnectivityChanged.listen(
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
            options: requestOptions,
          );
        }
      },
    );
  }
}

class ServiceCache {
  ServiceCache._internal();
  static ServiceCache _singleton = ServiceCache._internal();
  static ServiceCache get instance => _singleton;
  final cache = AppDatabase.instance;

  final Dio http = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com/",
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

  get(String key, String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async {
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
        return info.data;
      } catch (e) {
        print(e);
      }
    }

    return await cache.getDB(key);
  }

  post(String key, String url,
      {dynamic? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
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
        return info;
      } catch (e) {
        print(e);
      }
    }

    return await cache.getDB(key);
  }
}
