import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/modules/widgets/logo_widget.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).splashColor;
    return Scaffold(
        appBar: AppBar(
          title: const Text('LoginPage'),
        ),
        body: SafeArea(
            child: Align(
          alignment: const Alignment(0, -0.3),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Logo(),
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: primaryColor,
                    ),
                  ),
                  constraints: BoxConstraints.loose(
                    const Size(
                      500,
                      double.infinity,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
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
              ],
            ),
          ),
        )));
  }
}
