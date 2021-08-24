import 'package:get/get.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/data/repository/dataBase_repository.dart';
import 'package:hihome/routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    initLoading();
  }

  void initLoading() async {
    Get.put(DataBaseRepository(await Database().init()), permanent: true);
    await Future.delayed(Duration(seconds: 1));
    Get.offNamed(Routes.HOME);
  }
}
