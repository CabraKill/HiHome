import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/modules/details/details_controller.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'device_widget.dart';
import 'draggable_device.dart';

class DetailsView extends StatelessWidget {
  final DetailsController controller;
  final double offSetHeight;

  const DetailsView({
    required this.controller,
    required this.offSetHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Obx(() {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    FadeTransition(child: child, opacity: animation),
                child: controller.isAnalysisModeOn
                    ? SizedBox(
                        height: Get.height * 0.3,
                        child: SfSparkLineChart(
                          marker: const SparkChartMarker(
                            displayMode: SparkChartMarkerDisplayMode.all,
                          ),
                          labelDisplayMode: SparkChartLabelDisplayMode.all,
                          data: controller.deviceAnlysisLogs
                              .map((log) => double.parse(log.value))
                              .toList(),
                        ),
                      )
                    : const SizedBox.shrink(),
              );
            }),
          ),
        ),
      ],
    );
  }
}
