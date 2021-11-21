import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/modules/details/widgets/app_bar/app_bar_widget.dart';
import 'package:hihome/modules/details/widgets/draggable_device.dart';
import 'details_controller.dart';
import 'widgets/device_widget.dart';

class DetailsPage extends GetView<DetailsController> with DetailsAppBarWidget {
  final double offSetHeight;

  const DetailsPage({Key? key, required this.offSetHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: appBar(controller),
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
                            controller.updatePoint(device, point);
                          },
                          zoomType: controller.deviceZoom,
                          dragEnabled: controller.isEditModeOn,
                          titleEnable: controller.isTitleModeOn,
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
                child: Obx(() {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(child: child, opacity: animation),
                    child: controller.isEditModeOn
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.check_box_outline_blank),
                              DraggableDevice(
                                deviceType: DeviceType.lamp,
                                onDragEnd: controller.addDevice,
                              ),
                              DraggableDevice(
                                deviceType: DeviceType.valveOnOff,
                                onDragEnd: controller.addDevice,
                              ),
                              DraggableDevice(
                                deviceType: DeviceType.temperature,
                                onDragEnd: controller.addDevice,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    });
  }

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
