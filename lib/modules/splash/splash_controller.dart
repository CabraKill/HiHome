import 'package:get/get.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    initLoading();
  }

  void initLoading() async {
    Get.put(await DataBase().init(), permanent: true);
    await Future.delayed(const Duration(seconds: 1));
    Get.offNamed(Routes.login);
  }
}
