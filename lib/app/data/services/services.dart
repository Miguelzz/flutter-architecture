import 'package:get/get.dart';
import 'package:group/app/data/models/user.dart';
import 'package:group/app/data/services/interceptors.dart';
import 'package:group/app/data/services/list_services.dart';

class Services {
  static final ServiceCache _http = Get.find<ServiceCache>();

  Stream<User?> getUser(String id) =>
      _http.get<User>(ListServices.urlUser('/users/$id'));

  Stream<String?> login(String prefix, String phone) =>
      _http.post<String>(ListServices.login('/user/token'),
          data: {'prefix': prefix, 'phone': phone});
}
