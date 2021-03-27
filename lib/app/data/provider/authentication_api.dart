import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthenticationApi {
  final Dio _dio = Get.find<Dio>();

  Future<dynamic> newRequestToken() {
    this._dio.get('path');
    return {'name': 'Miguel'} as dynamic;
  }
}
