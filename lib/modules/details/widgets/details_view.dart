import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/domain/models/device_log.dart';
import 'package:hihome/modules/details/details_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controller.isAnalysisModeOn)
            Obx(() {
              return SizedBox(
                height: Get.height * controller.analysisHeightFactor,
                child: controller.currentDeviceInAnalysis == null ||
                        controller.deviceAnlysisLogsRx.isEmpty
                    ? const Center(
                        child: Text('Not data Available for now.'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Stack(
                          children: [
                            SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              // title: ChartTitle(
                              //   text: 'Values x Time',
                              // ),
                              // Enable legend
                              legend: Legend(isVisible: false),
                              series: <LineSeries<DeviceLogEntity, String>>[
                                LineSeries<DeviceLogEntity, String>(
                                  dataSource: controller.deviceAnlysisLogsRx,
                                  xValueMapper: (
                                    DeviceLogEntity log,
                                    index,
                                  ) =>
                                      "${log.date.hour}:${log.date.minute}:${log.date.second}",
                                  yValueMapper: (
                                    DeviceLogEntity log,
                                    _,
                                  ) =>
                                      log.type.isOnOffDevice
                                          ? (log.value == 'on' ? 1 : 0)
                                          : double.parse(log.value),
                                  // Enable data label
                                  dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                  ),
                                )
                              ],
                              palette: const <Color>[
                                Colors.cyan,
                                Color.fromRGBO(192, 108, 132, 1),
                                Color.fromRGBO(246, 114, 128, 1),
                                Color.fromRGBO(248, 177, 149, 1),
                                Color.fromRGBO(116, 180, 155, 1),
                                Color.fromRGBO(0, 168, 181, 1),
                                Color.fromRGBO(73, 76, 162, 1),
                                Color.fromRGBO(255, 205, 96, 1),
                                Color.fromRGBO(255, 240, 219, 1),
                                Color.fromRGBO(238, 238, 238, 1)
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                controller.currentDeviceInAnalysis!.name,
                                style: const TextStyle(
                                  color: Colors.cyan,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            }),
          SizedBox(
            width: double.infinity,
            height: Get.height - offSetHeight,
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, contraints) {
                    return Obx(
                      () => Stack(
                        children: [
                          Container(
                            width: contraints.maxWidth,
                            height: contraints.maxHeight,
                            margin: const EdgeInsets.all(4),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
          ),
        ],
      ),
    );
  }
}
