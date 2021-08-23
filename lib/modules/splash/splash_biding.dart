import 'package:get/get.dart';
import 'package:hihome/data/provider/firebase/firebaseSDK.dart';
import 'package:hihome/data/repository/dataBase_repository.dart';

import 'splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DataBaseRepository(FirestoreSDK()), permanent: true);
    Get.put<SplashController>(SplashController());
  }
}
