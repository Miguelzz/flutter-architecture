import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:group/views/pages/home/home_page.dart';
import 'package:group/views/pages/login/login_page.dart';
import 'package:group/views/pages/page2/page2_page.dart';
import 'package:group/views/pages/page3/page3_page.dart';
import 'package:group/views/pages/register/register_page.dart';
import 'package:group/views/pages/register/register_stap2_page.dart';
import 'package:group/views/pages/register/register_stap3_page.dart';
import 'package:group/views/pages/splash/splash_page.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/splash', page: () => SplashPage()),
  GetPage(name: '/login', page: () => LoginPage()),
  GetPage(name: '/register', page: () => RegisterPage()),
  GetPage(name: '/register/step2', page: () => RegisterStep2Page()),
  GetPage(name: '/register/step3', page: () => RegisterStep3Page()),
  GetPage(name: '/page/step2', page: () => Page2Page()),
  GetPage(name: '/page/step3', page: () => Page3Page()),
];
