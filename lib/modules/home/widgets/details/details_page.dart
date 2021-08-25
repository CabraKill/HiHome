import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'details_controller.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Offset position = Offset(70.9, 222.9);
    return GetBuilder<DetailsController>(
      init: DetailsController(),
      builder: (controller) => Column(children: [
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(builder: (context, contraints) {
              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      width: contraints.maxWidth * 10,
                      height: contraints.maxHeight * 10,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary)),
                      alignment: Alignment.center,
                      child: Text("oi"),
                    ),
                  ),
                  Obx(() {
                    print(controller.position.dy);
                    print(controller.position.dx);
                    return Positioned(
                      top: controller.position.dy - 115,
                      left: controller.position.dx - 9,
                      child: Icon(Icons.lightbulb),
                    );
                  }),
                ],
              );
            }),
          ),
        ),
        // Expanded(
        //   child: Center(
        //     child: InkWell(
        //       onTap: controller.switchState,
        //       child: Container(
        //         alignment: Alignment.center,
        //         child: Obx(() => Icon(
        //               Icons.lightbulb,
        //               size: 100,
        //               color: controller.onSwitch
        //                   ? Theme.of(context).accentColor
        //                   : null,
        //             )),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.check_box_outline_blank),
              Draggable<int>(
                data: 1,
                child: Icon(Icons.lightbulb),
                feedback: Icon(Icons.lightbulb),
                childWhenDragging: Container(
                  color: Colors.red,
                  child: Icon(Icons.lightbulb),
                ),
                onDragEnd: (data) {
                  controller.position = data.offset;
                  print('nova offset');
                  print(data.offset);
                },
              ),
              Icon(Icons.water),
              Icon(Icons.precision_manufacturing),
            ],
          ),
        )
      ]),
    );
  }
}
