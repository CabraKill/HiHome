import 'package:get/get.dart';
import 'package:hihome/data/repositories/login_repository.dart';
import 'package:hihome/domain/usecases/login_usecase.dart';

import 'login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
        () => LoginController(LoginUseCase(LoginRepository())));
  }
}
