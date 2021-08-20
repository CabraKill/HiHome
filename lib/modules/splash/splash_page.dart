import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('SplashPage')),
        body: SafeArea(
            child: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Center(
                child: CircularProgressIndicator(),
              )),
        )));
  }
}
