import 'package:get/get.dart';
import 'package:group/app/data/provider/authentication_api.dart';

class AuthenticationRepository {
  final AuthenticationApi _api = Get.find<AuthenticationApi>();

  Future<dynamic> newRequestToken() => _api.newRequestToken();
}
