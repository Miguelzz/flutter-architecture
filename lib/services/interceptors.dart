import 'dart:io';

import 'package:group/database/initialize-cache.dart';
import 'package:group/models/assets.dart';
import 'package:group/models/factories.dart';
import 'package:group/database/database.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'list_services.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  late final DioConnectivityRequestRetrier? requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        await requestRetrier?.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        print('******************');
        print(e);
        print('******************');
      }
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.sendTimeout ||
        err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.receiveTimeout ||
        err.type == DioErrorType.sendTimeout;
  }
}

class DioConnectivityRequestRetrier {
  final Dio dio = Dio();
  final Connectivity connectivity = Connectivity();

  DioConnectivityRequestRetrier();

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          //Complete the completer instead of returning

          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              //options: Options(),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
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

  final Dio http = Dio(
    BaseOptions(
      receiveTimeout: 5000,
      connectTimeout: 3000,
      followRedirects: false,
      receiveDataWhenStatusError: true,
    ),
  )..interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(),
      ),
    );

  Future<void> _addToken() async {
    http
      ..options.headers = {
        'token': await cache.getToken(),
      };
    print('*******************');
    print('TOKEN');
    print(http.options.headers);
    print('*******************');
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
        if (!InitializeCache.instance.useMock) {
          await _addToken();
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

        if (!InitializeCache.instance.useMock) {
          await _addToken();
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
        if (!InitializeCache.instance.useMock) {
          await _addToken();
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
        if (!InitializeCache.instance.useMock) {
          await _addToken();
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
