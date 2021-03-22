import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:group/views/pages/main/home/home_page.dart';
import 'package:group/views/pages/main/profile/profile_page.dart';
import 'package:group/views/pages/main/setting/setting_page.dart';

List<GetPage> mainRoutes = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/setting', page: () => SettingPage()),
  GetPage(name: '/profile', page: () => ProfilePage()),
];
