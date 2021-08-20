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
          Expanded(
            child: Container(
              child: Text("body"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Draggable<int>(
                  data: 1,
                  child: Icon(Icons.lightbulb),
                  feedback: Container(
                    color: Colors.black54,
                  ),
                  childWhenDragging: Icon(Icons.lightbulb),
                ),
                Icon(Icons.alarm),
                Icon(Icons.smart_toy),
              ],
            ),
          )
        ])));
  }
}
