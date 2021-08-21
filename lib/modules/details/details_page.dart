import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'details_controller.dart';

class DetailsPage extends GetView<DetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('DetailsPage')),
        body: SafeArea(
            child: Column(children: [
          // Expanded(
          //   child: DragTarget<int>(
          //     builder: (BuildContext context, List<Object?> candidateData,
          //         List<dynamic> rejectedData) {
          //       return Text("oi");
          //     },
          //     onAccept: (a) {
          //       print("$a accepted");
          //     },
          //     // child: Text("body"),
          //   ),
          // ),
          Expanded(
            child: Center(
              child: InkWell(
                onTap: controller.switchState,
                child: Container(
                  alignment: Alignment.center,
                  child: Obx(() => Icon(
                        Icons.lightbulb,
                        size: 100,
                        color: controller.onSwitch
                            ? Theme.of(context).accentColor
                            : null,
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Draggable<int>(
                  data: 1,
                  child: Container(
                      color: Colors.blue, child: Icon(Icons.lightbulb)),
                  feedback: Icon(Icons.lightbulb),
                  childWhenDragging: Container(
                      color: Colors.red, child: Icon(Icons.lightbulb)),
                ),
                Icon(Icons.alarm),
                Icon(Icons.smart_toy),
              ],
            ),
          )
        ])));
  }
}
