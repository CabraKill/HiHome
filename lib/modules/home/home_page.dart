import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/infra/valueState/valueState.dart';
import 'package:hihome/modules/home/widgets/details/details_page.dart';
import 'package:hihome/modules/home/widgets/homeChooser/homeChooser_widget.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
          actions: [
            IconButton(
                onPressed: controller.updateHouseList, icon: Icon(Icons.update))
          ],
        ),
        body: SafeArea(
            child: Obx(() => AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => SizeTransition(
                    child: child,
                    sizeFactor: animation,
                  ),
                  child: body(),
                ))));
  }

  Widget body() {
    if (controller.houseListState.state.value == HomeState.success) {
      if (controller.isHomeChoosed) return DetailsPage();
      return HouseChooser();
    }
    return CircularProgressIndicator();
  }
}
