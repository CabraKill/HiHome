import 'package:get/get.dart';
import 'package:hihome/modules/details/details_biding.dart';
import 'package:hihome/modules/details/details_page.dart';
import 'package:hihome/modules/home/home_binding.dart';
import 'package:hihome/modules/home/home_page.dart';
import 'package:hihome/modules/splash/splash_biding.dart';
import 'package:hihome/modules/splash/splash_page.dart';

import 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: Routes.HOME_DETAILS,
        page: () => DetailsPage(),
        binding: DetailsBinding()),
  ];
}
