// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_architecture/app/config/app_events.dart';
// import 'package:get/get.dart';
// import 'package:flutter_architecture/app/config/app-preloaded.dart';
// import 'package:flutter_architecture/app/data/models/factories.dart';
// import 'package:flutter_architecture/app/data/database/database.dart';
// import 'package:dio/dio.dart';
// import 'dart:async';

// enum TypeData { NATIVES, ENTITIES, LIST_NATIVES, LIST_ENTITIES }

// class Recent {
//   final DateTime date;
//   final String url;
//   final String body;

//   Recent(this.date, this.url, this.body);
// }

// class AppInterceptor {
//   static final AppDatabase _db = Get.find<AppDatabase>();
//   static final Connectivity _connectivity = Connectivity();

//   static List<Recent> recentPost = [];
//   static List<Recent> recentPut = [];
//   static List<Recent> recentGet = [];

//   final Dio _dio = Dio(
//     BaseOptions(
//         //receiveTimeout: 5000,
//         //connectTimeout: 3000,
//         //followRedirects: false,
//         //receiveDataWhenStatusError: true,
//         ),
//   );

//   Dio interceptor(String baseUrl) {
//     _dio.interceptors.clear();
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           print('interceptor');
//           print('TOKEN: ${EventsApp.stringToken}');
//           options.headers["x-token"] = EventsApp.stringToken;
//           handler.next(options);
//         },
//         onResponse: (response, handler) {
//           print('onResponse $response');
//           handler.next(response);
//         },
//         onError: (error, handler) {
//           print('onError ${error.message}');
//           // if (error.response?.statusCode == 403) {
//           //   _dio.interceptors.requestLock.lock();
//           //   _dio.interceptors.responseLock.lock();
//           //   handler.next(error);
//           // }
//           handler.next(error);
//         },
//       ),
//     );
//     _dio.options.baseUrl = baseUrl;
//     return _dio;
//   }

//   TypeData _isEntity(String entity) {
//     final isNative = 'bool' == entity ||
//         'int' == entity ||
//         'num' == entity ||
//         'double' == entity ||
//         'dynamic' == entity ||
//         'String' == entity;

//     if (isNative) return TypeData.NATIVES;
//     if (RegExp(r'^List<[a-zA-Z0-9]+>$').hasMatch(entity)) {
//       final matches = RegExp(r"List<(\w+)>").allMatches(entity);
//       final name = matches.toList()[0].group(1);
//       final type = _isEntity(name ?? '');

//       if (type == TypeData.ENTITIES) {
//         return TypeData.LIST_ENTITIES;
//       }

//       if (type == TypeData.NATIVES) {
//         return TypeData.LIST_ENTITIES;
//       }
//     }
//     if (factories[entity] != null) return TypeData.ENTITIES;
//     throw ('ERROR FACTORÍA NO EXISTE $entity');
//   }

//   Future<T> get<T>(
//           {required String url,
//           String base = '',
//           bool temporary = false,
//           Map<String, dynamic>? queryParameters,
//           Options? options,
//           CancelToken? cancelToken,
//           void Function(int, int)? onReceiveProgress}) =>
//       _get<T>(
//               url: url,
//               base: base,
//               temporary: temporary,
//               queryParameters: queryParameters,
//               options: options,
//               cancelToken: cancelToken,
//               onReceiveProgress: onReceiveProgress)
//           .first;

//   Stream<T> _get<T>(
//       {required String url,
//       String base = '',
//       bool temporary = false,
//       Map<String, dynamic>? queryParameters,
//       Options? options,
//       CancelToken? cancelToken,
//       void Function(int, int)? onReceiveProgress}) async* {
//     var type = _isEntity(T.toString());

//     bool recentQuery = false;
//     final connection =
//         (await _connectivity.checkConnectivity()) != ConnectivityResult.none;
//     // try {
//     //   recentGet.firstWhere((x) => x.url == url);
//     //   recentQuery = true;
//     // } catch (e) {
//     //   recentGet.add(Recent(DateTime.now(), url, ''));
//     // }

//     if (DataPreloaded.useMock) {
//       yield factories[T.toString()]!().createMock() as T;
//     } else if (temporary && !connection) {
//       if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
//         yield await _db.getKey(url) as T;
//       } else if (type == TypeData.ENTITIES) {
//         yield factories[T.toString()]!().fromJson(await _db.getKey(url)) as T;
//       } else if (type == TypeData.LIST_ENTITIES) {
//         final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
//         final name = matches.toList()[0].group(1);
//         yield factories[name]!().fromArray(await _db.getKey(url)) as T;
//       }
//     } else if (connection && !recentQuery) {
//       try {
//         recentQuery = true;
//         final http = interceptor(base);
//         final info = await http.get(
//           url,
//           queryParameters: queryParameters,
//           cancelToken: cancelToken,
//           onReceiveProgress: onReceiveProgress,
//           options: options,
//         );
//         recentQuery = false;

//         if (temporary) {
//           if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
//             _db.setTemporary(url, info.data);
//           } else if (type == TypeData.ENTITIES) {
//             _db.setTemporary(url,
//                 factories[T.toString()]!().fromJson(info.data)?.toJson() ?? {});
//           } else if (type == TypeData.LIST_ENTITIES) {
//             _db.setTemporary(
//                 url,
//                 info.data
//                     .map((x) =>
//                         factories[T.toString()]!().fromJson(x)?.toJson() ?? {})
//                     .toList());
//           }
//         }

//         if (type == TypeData.NATIVES || type == TypeData.LIST_NATIVES) {
//           yield info.data as T;
//         } else if (type == TypeData.ENTITIES) {
//           yield factories[T.toString()]!().fromJson(info.data) as T;
//         } else if (type == TypeData.LIST_ENTITIES) {
//           final matches = RegExp(r"List<(\w+)>").allMatches(T.toString());
//           final name = matches.toList()[0].group(1);
//           yield factories[name]!().fromArray(info.data) as T;
//         }
//       } on DioError catch (e) {
//         final data = e.response?.data ?? {'message': 'Error!', 'errors': []};
//         Get.defaultDialog(
//           title: data['message'] ?? 'Error!',
//           content: Column(
//             children: [
//               ...(data['errors'] ?? []).map((x) => Text('• $x')).toList()
//             ],
//           ),
//         );
//         recentPut.removeWhere((x) => x.url == url);
//       } catch (e) {
//         print(e);
//         Get.defaultDialog(
//           title: 'An unexpected error occurred!',
//           content: Column(
//             children: [Text('• try again later'), Text(e.toString())],
//           ),
//         );
//         recentPut.removeWhere((x) => x.url == url);
//       }
//     } else if (!connection) {
//       Get.defaultDialog(
//         title: 'No internet connection!',
//         content: Column(
//           children: [Text('• try again later')],
//         ),
//       );
//       recentPut.removeWhere((x) => x.url == url);
//     }
//   }
