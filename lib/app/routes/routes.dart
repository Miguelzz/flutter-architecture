import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flutter_architecture/app/modules/login/login_page.dart';
import 'package:flutter_architecture/app/modules/login/validate_login_page.dart';
import 'package:flutter_architecture/app/modules/splash/splash_page.dart';
import 'package:flutter_architecture/app/modules/main/home/home_page.dart';
import 'package:flutter_architecture/app/modules/main/profile/profile_page.dart';
import 'package:flutter_architecture/app/modules/main/setting/setting_page.dart';
import 'package:flutter_architecture/app/modules/register/register_page.dart';
import 'package:flutter_architecture/app/modules/register/register_stap2_page.dart';
import 'package:flutter_architecture/app/modules/register/register_stap3_page.dart';

List<GetPage> routes = [
  // MAIN
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/setting', page: () => SettingPage()),
  GetPage(name: '/profile', page: () => ProfilePage()),

  /// REGISTER
  GetPage(name: '/register', page: () => RegisterPage()),
  GetPage(name: '/register/step2', page: () => RegisterStep2Page()),
  GetPage(name: '/register/step3', page: () => RegisterStep3Page()),

  // OTHERS
  GetPage(name: '/splash', page: () => SplashPage()),
  GetPage(name: '/login', page: () => LoginPage()),
  GetPage(name: '/validate-login', page: () => ValidateLoginPage()),
];
