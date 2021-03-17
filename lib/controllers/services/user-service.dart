import 'package:myArchitecture/controllers/database/database.dart';
import 'package:myArchitecture/controllers/services/interceptors.dart';

import '../models/user.dart';

class UserService {
  UserService._internal();
  static UserService _singleton = UserService._internal();
  static UserService get instance => _singleton;
  final http = Services.instance;
  final cache = AppDatabase.instance;

  Future<User> getUsers() async =>
      User.fromJson(await http.get('user', 'users/1'));
}
