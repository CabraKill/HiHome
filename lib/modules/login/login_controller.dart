import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/helper/loginError_type.dart';
import 'package:hihome/domain/Ilogin_usecase.dart';

class LoginController extends GetxController {
  final ILoginUseCase loginUseCase;
  LoginController(this.loginUseCase);

  final loginFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  void login() async {
    final result = await loginUseCase(
        loginFieldController.text, passwordFieldController.text);
    result.fold(
        (failure) => showLoginFailure(failure),
        (loginResult) => Get.defaultDialog(
            title: "Success",
            content: Text(
              "Token: ${loginResult.token.substring(0, 10) + "..."}",
            )));
  }

  void showLoginFailure(LoginFailureType failure) {
    Get.defaultDialog(title: "Error", content: Text(failure.description));
  }
}
