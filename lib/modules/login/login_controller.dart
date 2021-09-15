import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/helper/auth_error/login_failure_type.dart';
import 'package:hihome/data/models/userCredentials.dart';
import 'package:hihome/domain/usecases/Ilogin_usecase.dart';
import 'package:hihome/routes/routes.dart';

class LoginController extends GetxController {
  final ILoginUseCase loginUseCase;
  LoginController(this.loginUseCase);

  final loginFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  void login() async {
    final result = await loginUseCase(
        loginFieldController.text, passwordFieldController.text);
    result.fold((failure) => showLoginFailure(failure), loginSuccess);
  }

  void showLoginFailure(LoginFailureType failure) {
    Get.defaultDialog(title: "Error", content: Text(failure.description));
  }

  void loginSuccess(UserCredentials userCredentials) async {
    await Get.offNamed(Routes.HOME, arguments: userCredentials);
    Get.defaultDialog(
        title: "Success",
        content: Text(
          "Olá!",
        ));
  }
}
