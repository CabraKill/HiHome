import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('SplashPage')),
        body: SafeArea(
            child: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Center(
                child: CircularProgressIndicator(),
              )),
        )));
  }
}
