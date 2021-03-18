import 'dart:async';
import 'package:get/get.dart';
import 'package:myArchitecture/models/user.dart';
import 'package:myArchitecture/services/services.dart';

class HomeController extends GetxController {
  static Services _services = Services.instance;

  User? user;

  Future<void> getUser() async {
    print('***********');
    user = await _services.getUsers();
    print('***********');
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    print('HOME');
  }
}
