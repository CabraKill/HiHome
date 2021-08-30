import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('LoginPage')),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "email",
                  ),
                  controller: controller.loginFieldController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "password",
                  ),
                  controller: controller.passwordFieldController,
                ),
                Padding(padding: const EdgeInsets.only(top: 10)),
                Align(
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    onPressed: controller.login,
                    child: Text("Login"),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
