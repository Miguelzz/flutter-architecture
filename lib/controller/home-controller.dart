import 'dart:async';
import 'package:get/get.dart';
import 'package:myArchitecture/database/database.dart';
import 'package:myArchitecture/models/user.dart';
import 'package:myArchitecture/services/services.dart';

class HomeController extends GetxController {
  static final AppDatabase _cache = AppDatabase.instance;
  static final Services _services = Services.instance;

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
    user = await _services.getUsers(useCache: true);
    update();
    print('HOME');
  }
}
