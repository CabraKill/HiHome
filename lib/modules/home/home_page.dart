import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/modules/widgets/houseBase_widget.dart';
import 'package:hihome/modules/widgets/house_widget.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(title: Text('HomePage')),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1.4,
              child: Column(
                children: [
                  Expanded(
                      child: Row(
                          children: controller.houseList
                              .map((house) => House(
                                    name: house.name,
                                    onTap: () =>
                                        controller.goToDetails(house.id),
                                  ))
                              .toList())),
                  HouseBase()
                ],
              ),
            ),
          ),
        ))));
  }
}
