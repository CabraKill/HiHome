import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/modules/home/widgets/details/details_page.dart';
import 'package:hihome/modules/home/widgets/homeChooser/homeChooser_widget.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('HomePage'),
      actions: [
        IconButton(
            onPressed: controller.updateHouseList, icon: Icon(Icons.update))
      ],
    );
    return Scaffold(
        appBar: appBar,
        body: SafeArea(
            child: Obx(() => AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => SizeTransition(
                    child: child,
                    sizeFactor: animation,
                  ),
                  child: controller.houseListState.builder(onSuccess: () {
                    if (controller.isHomeChoosed)
                      return DetailsPage(
                        offSetHeight: appBar.preferredSize.height,
                      );
                    return HouseChooser();
                  }),
                ))));
  }
}
