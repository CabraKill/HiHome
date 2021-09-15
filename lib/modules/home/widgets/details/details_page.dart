import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/modules/home/widgets/details/device_widget.dart';
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
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: contraints.maxWidth * 10,
                      height: contraints.maxHeight * 10,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary)),
                      alignment: Alignment.center,
                      child: const Text("oi"),
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
                  const Icon(Icons.check_box_outline_blank),
                  Draggable<DeviceModel>(
                    child: const Icon(Icons.lightbulb),
                    feedback: const Icon(Icons.lightbulb),
                    childWhenDragging: Icon(Icons.lightbulb,
                        color: Theme.of(context).colorScheme.secondary),
                    onDragEnd: (data) {
                      //TODO: make them relative
                      final dx = data.offset.dx;
                      final dy = data.offset.dy;
                      final device = DeviceModel(
                          id: '0',
                          name: '',
                          state: '',
                          point: DevicePointModel(x: dx, y: dy));
                      final widget = DeviceWidget(
                        device: device,
                        offset: Offset(0, offSetHeight),
                      );
                      controller.addDeviceToList(widget);
                      debugPrint(controller.itens.toString());
                    },
                  ),
                  const Icon(Icons.water),
                  const Icon(Icons.precision_manufacturing),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
