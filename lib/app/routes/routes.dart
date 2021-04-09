import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:group/app/modules/login/login_page.dart';
import 'package:group/app/modules/login/validate_login_page.dart';
import 'package:group/app/modules/splash/splash_page.dart';
import 'package:group/app/routes/pages/main_routes.dart';
import 'package:group/app/routes/pages/register_routes.dart';

List<GetPage> routes = [
  ...mainRoutes,
  ...registerRoutes,
  GetPage(name: '/splash', page: () => SplashPage()),
  GetPage(name: '/login', page: () => LoginPage()),
  GetPage(name: '/validate-login', page: () => ValidateLoginPage()),
];
