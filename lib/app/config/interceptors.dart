import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/models/message_error.dart';
import 'package:get/get.dart';
import 'package:flutter_architecture/app/data/database/data-preloaded.dart';
import 'package:flutter_architecture/app/data/models/factories.dart';
import 'package:flutter_architecture/app/data/database/database.dart';
import 'package:dio/dio.dart';
import 'dart:async';

enum TypeData { NATIVES, ENTITIES, LIST_NATIVES, LIST_ENTITIES }

class Recent {
  final DateTime date;
  final String url;
  final String body;

  Recent(this.date, this.url, this.body);
}

class ServiceTemporary {
  static final AppDatabase _db = Get.find<AppDatabase>();

  static List<Recent> recentPost = [];
  static List<Recent> recentGet = [];

  final Dio _dio = Dio(
    BaseOptions(
        //receiveTimeout: 5000,
        //connectTimeout: 3000,
        //followRedirects: false,
        //receiveDataWhenStatusError: true,
        ),
  );

  Dio interceptor(String baseUrl) {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('interceptor');
          print('TOKEN: ${DataPreloaded.token.token}');
          options.headers["x-token"] = DataPreloaded.token.token ?? '';
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('onResponse $response');
          handler.next(response);
        },
        onError: (error, handler) {
          print('onError');
          // if (error.response?.statusCode == 403) {
          //   _dio.interceptors.requestLock.lock();
          //   _dio.interceptors.responseLock.lock();
          //   handler.next(error);
          // }
          handler.next(error);
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
        'dynamic' == entity ||
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

  Stream<T> get<T>(
      {required String url,
      String base = '',
      bool temporary = false,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async* {
    var type = _isEntity(T.toString());
    bool recentQuery = false;

    try {
      recentGet.firstWhere((x) => x.url == url);
      recentQuery = true;
    } catch (e) {
      recentGet.add(Recent(DateTime.now(), url, ''));
    }

    if (DataPreloaded.useMock) {
      yield factories[T.toString()]!().createMock() as T;
    } else if (temporary && !DataPreloaded.connection) {
      if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
        yield await _db.getKey(url) as T;
      } else if (type == TypeData.ENTITIES) {
        yield factories[T.toString()]!().fromJson(await _db.getKey(url)) as T;
      } else if (type == TypeData.LIST_ENTITIES) {
        final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
        final name = matches.toList()[0].group(1);
        yield (await _db.getKey(url))
            .map((x) => factories[name]!().fromJson(x))
            .toList() as T;
      }
    } else if (DataPreloaded.connection && !recentQuery) {
      try {
        final http = interceptor(base);
        final info = await http.get(
          url,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: options,
        );

        if (temporary) {
          if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
            _db.setTemporary(url, info.data);
          } else if (type == TypeData.ENTITIES) {
            _db.setTemporary(url,
                factories[T.toString()]!().fromJson(info.data)?.toJson() ?? {});
          } else if (type == TypeData.LIST_ENTITIES) {
            _db.setTemporary(
                url,
                info.data
                    .map((x) =>
                        factories[T.toString()]!().fromJson(x)?.toJson() ?? {})
                    .toList());
          }
        }

        if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
          yield info.data as T;
        } else if (type == TypeData.ENTITIES) {
          yield factories[T.toString()]!().fromJson(info.data) as T;
        } else if (type == TypeData.LIST_ENTITIES) {
          final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
          final name = matches.toList()[0].group(1);
          yield info.data.map((x) => factories[name]!().fromJson(x)).toList()
              as T;
        }
      } on DioError catch (e) {
        throw MessageError(message: e.message, response: e.response);
      } catch (e) {
        print(e);
      }
    }
  }

  Stream<T> post<T>(
      {required String url,
      String base = '',
      bool temporary = false,
      dynamic? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async* {
    var type = _isEntity(T.toString());

    bool recentQuery = false;
    try {
      recentPost.firstWhere((x) => x.url == url);
      recentQuery = true;
    } catch (e) {
      recentPost.add(Recent(DateTime.now(), url, data.toString()));
    }

    if (DataPreloaded.useMock) {
      yield factories[T.toString()]!().createMock() as T;
    } else if (temporary && !DataPreloaded.connection) {
      if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
        yield await _db.getKey(url) as T;
      } else if (type == TypeData.ENTITIES) {
        yield factories[T.toString()]!().fromJson(await _db.getKey(url)) as T;
      } else if (type == TypeData.LIST_ENTITIES) {
        final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
        final name = matches.toList()[0].group(1);
        yield (await _db.getKey(url))
            .map((x) => factories[name]!().fromJson(x))
            .toList() as T;
      }
    } else if (DataPreloaded.connection && !recentQuery) {
      try {
        final http = interceptor(base);

        final info = await http.post(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onReceiveProgress,
        );

        if (temporary) {
          if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
            _db.setTemporary(url, info.data);
          } else if (type == TypeData.ENTITIES) {
            _db.setTemporary(url,
                factories[T.toString()]!().fromJson(info.data)?.toJson() ?? {});
          } else if (type == TypeData.LIST_ENTITIES) {
            _db.setTemporary(
                url,
                info.data
                    .map((x) =>
                        factories[T.toString()]!().fromJson(x)?.toJson() ?? {})
                    .toList());
          }
        }

        if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
          yield info.data as T;
        } else if (type == TypeData.ENTITIES) {
          yield factories[T.toString()]!().fromJson(info.data) as T;
        } else if (type == TypeData.LIST_ENTITIES) {
          final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
          final name = matches.toList()[0].group(1);
          yield info.data.map((x) => factories[name]!().fromJson(x)).toList()
              as T;
        }
      } on DioError catch (e) {
        throw MessageError(message: e.message, response: e.response);
      } catch (e) {
        print(e);
      }
    }
  }
}