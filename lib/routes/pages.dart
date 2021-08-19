import 'package:get/get.dart';
import 'package:hihome/modules/splash/splash_page.dart';

import 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
    )
  ];
}
