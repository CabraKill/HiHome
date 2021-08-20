import 'package:get/get.dart';
import 'package:hihome/data/provider/firebase/mock/firebaseMock.dart';
import 'package:hihome/data/repository/dataBase_repository.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
