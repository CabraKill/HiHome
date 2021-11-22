import 'package:get/get.dart';
import 'package:hihome/modules/home/home_binding.dart';
import 'package:hihome/modules/home/home_page.dart';
import 'package:hihome/modules/login/login_binding.dart';
import 'package:hihome/modules/login/login_page.dart';
import 'package:hihome/modules/splash/splash_biding.dart';
import 'package:hihome/modules/splash/splash_page.dart';

import 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
