import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/modules/details/widgets/draggable_device.dart';
import 'details_controller.dart';
import 'widgets/device_widget.dart';

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
                        onTap: () => controller.deviceOnTap(device),
                        onDeviceDragEnd: (point) {
                          controller.updateDevice(device..point = point);
                        },
                        key: ValueKey(
                          device.id +
                              (device.point?.x.toString() ?? "") +
                              (device.point?.y.toString() ?? ""),
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
                  DraggableDevice(
                    deviceType: DeviceType.lamp,
                    onDragEnd: controller.testDialog,
                  ),
                  DraggableDevice(
                    deviceType: DeviceType.valveOnOff,
                    onDragEnd: controller.testDialog,
                  ),
                  DraggableDevice(
                    deviceType: DeviceType.temperature,
                    onDragEnd: controller.testDialog,
                  ),
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
            onPressed: controller.updateDeviceList,
            icon: const Icon(Icons.update),
          )
        ],
      );

  void addDevice(DeviceType type, DevicePointModel point) {
    controller.addDeviceToList(createDeviceFromType(type, point));
    debugPrint(controller.devices.toString());
  }

  DeviceEntity createDeviceFromType(DeviceType type, DevicePointModel point) {
    return DeviceEntity(
      id: '0',
      name: '',
      bruteValue: '',
      point: point,
      type: type,
      path: '',
    );
  }
}
