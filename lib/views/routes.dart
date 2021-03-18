import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:myArchitecture/views/home/home.dart';
import 'package:myArchitecture/views/login/login-page.dart';
import 'package:myArchitecture/views/shared/splash_page.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/splash', page: () => SplashPage()),
  GetPage(name: '/login', page: () => LoginPage()),
];
