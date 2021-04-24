import 'package:flutter_architecture/app/modules/login/user_info_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flutter_architecture/app/modules/login/number_page.dart';
import 'package:flutter_architecture/app/modules/login/terms_page.dart';
import 'package:flutter_architecture/app/modules/login/read_terms_page.dart';
import 'package:flutter_architecture/app/modules/login/validate_login_page.dart';
import 'package:flutter_architecture/app/modules/main/home/home_page.dart';
import 'package:flutter_architecture/app/modules/main/profile/profile_page.dart';
import 'package:flutter_architecture/app/modules/main/setting/setting_page.dart';

List<GetPage> routes = [
  // MAIN
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/setting', page: () => SettingPage()),
  GetPage(name: '/profile', page: () => ProfilePage()),

  // OTHERS
  GetPage(name: '/terms', page: () => TermsPage()),
  GetPage(name: '/read-terms', page: () => ReadTermsPage()),

  GetPage(name: '/validate-number', page: () => NumberPage()),
  GetPage(name: '/validate-code', page: () => ValidateLoginPage()),
  GetPage(name: '/user-info', page: () => UserInfoPage()),
];
