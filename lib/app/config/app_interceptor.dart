import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/app_events.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';
import 'package:flutter_architecture/app/data/models/assets.dart';
import 'package:flutter_architecture/app/config/app-preloaded.dart';
import 'package:flutter_architecture/app/data/models/factories.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:dio/src/response.dart' as res;

class ErrorApi {
  final DioError? error;
  late String message;
  late List<Widget> errors;

  ErrorApi(this.error) {
    final data = this.error?.response?.data ?? {};

    final _errors =
        (data['errors'] ?? []).map<Widget>((x) => Text('• $x')).toList();
    this.message = data['message'] ?? 'Error!';
    this.errors = [
      Text('• Status: ${error?.response?.statusCode}'),
      ..._errors
    ];
  }
}

class MethodResult extends MethodsApp {
  final Future<res.Response<dynamic>> http;
  bool _stop = true;
  String _title = '';

  MethodResult(this.http);

  void showMessage(String title) {
    _title = title;
  }

  Future<bool> _stopDialog() async {
    while (!_stop) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    return _stop;
  }

  Future<dynamic> _exitMessage() async {
    if (_title != '') {
      print('nueva petición');
      _stop = false;
      Get.defaultDialog(
          title: _title,
          content: CircularProgressIndicator(backgroundColor: PRIMARY_COLOR),
          onWillPop: () async => await _stopDialog());

      try {
        final data = (await this.http).data;
        Get.back();
        _stop = true;
        return data;
      } catch (e) {
        Get.back();
        _stop = true;
        throw 'request error!';
      }
    } else {
      return (await this.http).data;
    }
  }

  Future<T> mapEntity<T extends Entity<T>>() async {
    final data = await _exitMessage();
    late T result;
    if (DataPreloaded.useMock)
      result = factories[T.toString()]!().createMock() as T;
    else
      result = factories[T.toString()]!().fromJson(data) as T;

    return result;
  }

  Future<List<T>> mapListEntity<T extends Entity<T>>() async {
    final data = await _exitMessage();
    late List<T> result;

    if (DataPreloaded.useMock)
      result = [null, null, null]
          .map<T>((x) => factories[T.toString()]!().createMock() as T)
          .toList();
    else
      result = data
          .map<T>((x) => factories[T.toString()]!().fromJson(x) as T)
          .toList();

    return result;
  }

  Future<T> mapType<T>() async {
    final data = await _exitMessage();
    return super.methodMapType<T>(data)!;
  }

  Future<List<T>> mapListType<T>() async {
    final data = await _exitMessage();
    late List<T> result;
    if (DataPreloaded.useMock)
      result =
          [null, null, null].map<T>((x) => super.methodMapType<T>(x)!).toList();
    else
      result = data.map<T>(super.methodMapType).toList();

    return result;
  }
}

class AppInterceptor {
  final Dio _dio = Dio(
    BaseOptions(
        //receiveTimeout: 5000,
        //connectTimeout: 3000,
        //followRedirects: false,
        //receiveDataWhenStatusError: true,
        ),
  );

  Dio _interceptor() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('interceptor');
          print('TOKEN: ${EventsApp.stringToken}');
          options.headers["x-token"] = EventsApp.stringToken;
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('onResponse $response');

          handler.next(response);
        },
        onError: (error, handler) {
          print('onError ${error.message}');

          Future.delayed(Duration(milliseconds: 300)).then((value) {
            final data = ErrorApi(error);
            Get.defaultDialog(
              title: data.message,
              content: Column(children: data.errors),
            );
          });

          handler.next(error);
        },
      ),
    );
    return _dio;
  }

  MethodResult get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) {
    print('$url, $queryParameters');
    final http = _interceptor();
    final info = http.get(url, queryParameters: queryParameters);
    return MethodResult(info);
  }

  MethodResult post({
    required String url,
    dynamic? data,
    Map<String, dynamic>? queryParameters,
  }) {
    final http = _interceptor();
    final info = http.post(url, data: data, queryParameters: queryParameters);
    return MethodResult(info);
  }

  MethodResult put({
    required String url,
    dynamic? data,
    Map<String, dynamic>? queryParameters,
  }) {
    final http = _interceptor();
    final info = http.put(url, data: data, queryParameters: queryParameters);
    return MethodResult(info);
  }

  MethodResult delete({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) {
    final http = _interceptor();
    final info = http.delete(url, queryParameters: queryParameters);
    return MethodResult(info);
  }
}
