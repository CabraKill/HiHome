import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/modules/home/widgets/details/bulb_widget.dart';
import 'details_controller.dart';

class DetailsPage extends StatelessWidget {
  final double offSetHeight;

  const DetailsPage({Key? key, required this.offSetHeight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(
      init: DetailsController(),
      builder: (controller) => Stack(
        children: [
          LayoutBuilder(builder: (context, contraints) {
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
                              color: Theme.of(context).colorScheme.secondary)),
                      alignment: Alignment.center,
                      child: Text("oi"),
                    ),
                  ),
                ],
              );
            });
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.check_box_outline_blank),
                  Draggable<DeviceModel>(
                    child: Icon(Icons.lightbulb),
                    feedback: Icon(Icons.lightbulb),
                    childWhenDragging: Icon(Icons.lightbulb,
                        color: Theme.of(context).accentColor),
                    onDragEnd: (data) {
                      final widget = BulbWidget(
                        xPosition: data.offset.dx -
                            MediaQuery.of(context).padding.left,
                        yPosition: data.offset.dy -
                            MediaQuery.of(context).padding.top -
                            offSetHeight,
                      );
                      controller.addDeviceToList(widget);
                      print(controller.itens);
                    },
                  ),
                  Icon(Icons.water),
                  Icon(Icons.precision_manufacturing),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
