import 'package:get/get.dart';
import 'package:hihome/data/repositories/login_repository_impl.dart';
import 'package:hihome/data/usecases/login_usecase.dart';

import 'login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
        () => LoginController(LoginUseCaseImpl(LoginRepositoryImpl())));
  }
}
