import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'details_controller.dart';
import 'device_widget.dart';

class DetailsPage extends GetView<DetailsController> {
  final double offSetHeight;

  const DetailsPage({Key? key, required this.offSetHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, contraints) {
              return Obx(
                () => Stack(
                  children: [
                    Container(
                      width: contraints.maxWidth,
                      height: contraints.maxHeight,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    ...controller.devices.map<DeviceWidget>(
                      (device) => DeviceWidget(
                        device: device,
                        offset: Offset(0, offSetHeight),
                        onTap: () => print("oi"),
                        key: ValueKey(
                          device.id +
                              device.point.x.toString() +
                              device.point.y.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
                    childWhenDragging: Icon(
                      Icons.lightbulb,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onDragEnd: (data) {
                      //TODO: make them relative
                      final dx = data.offset.dx;
                      final dy = data.offset.dy;
                      final device = DeviceModel(
                        id: '0',
                        name: '',
                        state: '',
                        point: DevicePointModel(x: dx, y: dy),
                      );
                      controller.addDeviceToList(device);
                      debugPrint(controller.devices.toString());
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

  AppBar get appBar => AppBar(
        title: const Text('HomePage'),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: implement on the controller
            },
            icon: const Icon(Icons.update),
          )
        ],
      );
}
