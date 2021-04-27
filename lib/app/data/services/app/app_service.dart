import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/models/demo.dart';
import 'package:flutter_architecture/app/data/services/app/app_gateway.dart';
import 'package:flutter_architecture/app/config/app_interceptor.dart';
import 'package:get/get.dart';

class AppService extends MainGateway {
  static final AppInterceptor _http = Get.find<AppInterceptor>();
  static final identity = Constants.IDENTITY;

  @override
  Future<List<Demo>> searchOne(String search) async {
    return _http.get<List<Demo>>(
        url: '$identity/app/search/one', queryParameters: {'q': search});
  }

  @override
  Future<List<Demo>> searchTwo(String search) async {
    return _http.get<List<Demo>>(
        url: '$identity/app/search/one', queryParameters: {'q': search});
  }

  @override
  Future<List<Demo>> searchThree(String search) async {
    return _http.get<List<Demo>>(
        url: '$identity/app/search/one', queryParameters: {'q': search});
  }
}
