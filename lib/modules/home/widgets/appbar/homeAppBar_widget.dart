import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/modules/home/home_controller.dart';

class HomeAppBarPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
            child: Icon(Icons.face), duration: Duration(milliseconds: 300))
      ],
    );
  }
}
