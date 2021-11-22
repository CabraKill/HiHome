import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/modules/widgets/logo_widget.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: const Center(
              child: Logo(),
            ),
          ),
        ),
      ),
    );
  }
}
