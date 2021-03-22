import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:group/views/pages/login/login_page.dart';
import 'package:group/views/pages/splash/splash_page.dart';
import 'package:group/views/routes/pages/main_routes.dart';
import 'package:group/views/routes/pages/register_routes.dart';

List<GetPage> routes = [
  ...mainRoutes,
  ...registerRoutes,
  GetPage(name: '/splash', page: () => SplashPage()),
  GetPage(name: '/login', page: () => LoginPage()),
];
