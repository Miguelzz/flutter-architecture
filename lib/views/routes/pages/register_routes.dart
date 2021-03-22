import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:group/views/pages/register/register_page.dart';
import 'package:group/views/pages/register/register_stap2_page.dart';
import 'package:group/views/pages/register/register_stap3_page.dart';

List<GetPage> registerRoutes = [
  GetPage(name: '/register', page: () => RegisterPage()),
  GetPage(name: '/register/step2', page: () => RegisterStep2Page()),
  GetPage(name: '/register/step3', page: () => RegisterStep3Page()),
];
