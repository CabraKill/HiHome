import 'package:get/get.dart';
import 'package:hihome/routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    initLoading();
  }

  void initLoading() async {
    await Future.delayed(Duration(seconds: 1));
    Get.offNamed(Routes.HOME);
  }
}
