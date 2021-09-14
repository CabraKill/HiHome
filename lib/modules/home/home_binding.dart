import 'package:get/get.dart';
import 'package:hihome/data/repositories/database_repository.dart';
import 'package:hihome/data/repositories/userDetails_repository.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
        () => HomeController(UserDetailsRepository(), DatabaseRepository()));
  }
}
