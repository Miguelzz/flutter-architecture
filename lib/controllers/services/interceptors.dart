import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    @required this.requestRetrier,
  });

  @override
  Future onError(DioError err) async {
    if (_shouldRetry(err)) {
      try {
        print('%%%%%%%%%%%%%%%%%%%%');
        print(err);
        print('%%%%%%%%%%%%%%%%%%%%');
        await requestRetrier.scheduleRequestRetry(err.request);
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
          streamSubscription.cancel();
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

class Services {
  Services._internal();
  static Services _singleton = Services._internal();
  static Dio get instance => _singleton.http;
  final Dio http = Dio(BaseOptions(
    baseUrl: "",
    headers: {"Accept": "application/json"},
    responseType: ResponseType.json,
    receiveTimeout: 30000,
    connectTimeout: 5000,
    followRedirects: false,
    receiveDataWhenStatusError: true,
  ));
  // ..interceptors.add(
  //   RetryOnConnectionChangeInterceptor(
  //     requestRetrier: DioConnectivityRequestRetrier(),
  //   ),
  // );
}
