import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/modules/home/widgets/details/details_page.dart';
import 'package:hihome/modules/home/widgets/homeChooser/homeChooser_widget.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('HomePage')),
        body: SafeArea(
            child: Obx(() => AnimatedSwitcher(
                  duration: Duration(milliseconds: 1000),
                  transitionBuilder: (child, animation) => SizeTransition(
                    child: child,
                    sizeFactor: animation,
                  ),
                  child:
                      controller.isHomeChoosed ? DetailsPage() : HouseChooser(),
                ))));
  }
}
