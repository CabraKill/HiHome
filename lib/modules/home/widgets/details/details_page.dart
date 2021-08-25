import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/modules/home/widgets/details/bulb_widget.dart';
import 'details_controller.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              return Obx(() {
                return Stack(
                  children: [
                    ...controller.itens,
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        width: contraints.maxWidth * 10,
                        height: contraints.maxHeight * 10,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        alignment: Alignment.center,
                        child: Text("oi"),
                      ),
                    ),
                  ],
                );
              });
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
              Draggable<DeviceModel>(
                child: Icon(Icons.lightbulb),
                feedback: Icon(Icons.lightbulb),
                childWhenDragging: Container(
                  color: Colors.red,
                  child: Icon(Icons.lightbulb),
                ),
                onDragEnd: (data) {
                  final widget = BulbWidget(
                    xPosition: data.offset.dx,
                    yPosition: data.offset.dy,
                  );
                  controller.addWidgetToList(widget);
                  print(controller.itens);
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
