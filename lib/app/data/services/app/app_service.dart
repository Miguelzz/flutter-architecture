import 'package:flutter_architecture/app/config/constants.dart';
import 'package:flutter_architecture/app/data/models/demo.dart';
import 'package:flutter_architecture/app/data/services/app/app_gateway.dart';
import 'package:flutter_architecture/app/config/app_interceptor.dart';
import 'package:get/get.dart';

class AppService extends MainGateway {
  static final AppInterceptor _http = Get.find<AppInterceptor>();
  static final search = '${Constants.IDENTITY}/app/search';

  @override
  Future<List<Demo>> searchOne(String query) async {
    final result = _http.get(url: '$search/one', queryParameters: {'q': query});
    return result.mapListEntity<Demo>();
  }

  @override
  Future<List<Demo>> searchTwo(String query) async {
    final result = _http.get(url: '$search/one', queryParameters: {'q': query});
    return result.mapListEntity<Demo>();
  }

  @override
  Future<List<Demo>> searchThree(String query) async {
    final result = _http.get(url: '$search/one', queryParameters: {'q': query});
    return result.mapListEntity<Demo>();
  }
}
