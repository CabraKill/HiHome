import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('LoginPage')),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "email",
                  ),
                  controller: controller.loginFieldController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "password",
                  ),
                  controller: controller.passwordFieldController,
                  obscureText: true,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Align(
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    onPressed: controller.login,
                    child: const Text('Login'),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
