import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hihome/modules/widgets/houseBase_widget.dart';
import 'package:hihome/modules/widgets/house_widget.dart';

import '../../home_controller.dart';

class HouseChooser extends GetView<HomeController> {
  const HouseChooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1.4,
          child: Column(
            children: [
              Expanded(
                  child: Obx(() => Row(
                      children: controller.houseList.value
                          .map((house) => HouseWidget(
                                name: house.name,
                                onTap: () => controller.goToDetails(house),
                              ))
                          .toList()))),
              HouseBase()
            ],
          ),
        ),
      ),
    );
  }
}
