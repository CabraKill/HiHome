import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/modules/home/widgets/details/details_page.dart';
import 'package:hihome/modules/home/widgets/homeChooser/home_chooser_widget.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarInstance = appBar;
    return Scaffold(
      appBar: appBarInstance,
      body: SafeArea(
          child: Obx(() => AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => SizeTransition(
                  child: child,
                  sizeFactor: animation,
                ),
                child: controller.family.builder(onSuccess: () {
                  if (controller.isHomeChoosed) {
                    return DetailsPage(
                      offSetHeight: appBar.preferredSize.height,
                    );
                  }
                  return const HouseChooser();
                }),
              ))),
    );
  }

  AppBar get appBar => AppBar(
        title: const Text('HomePage'),
        actions: [
          IconButton(
              onPressed: controller.updateFamily,
              icon: const Icon(Icons.update))
        ],
      );
}
