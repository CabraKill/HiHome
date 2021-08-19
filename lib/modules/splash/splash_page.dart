import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/modules/splash/widgets/houseBase_widget.dart';
import 'package:hihome/modules/splash/widgets/house_widget.dart';
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
                child: AspectRatio(
                  aspectRatio: 1.4,
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          House(
                            key: ValueKey('1'),
                          ),
                          House(
                            key: ValueKey('2'),
                          ),
                        ],
                      )),
                      HouseBase()
                    ],
                  ),
                ),
              )),
        )));
  }
}
