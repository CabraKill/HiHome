import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/domain/models/device_log.dart';
import 'package:hihome/modules/details/details_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisDeviceGraph extends StatelessWidget {
  const AnalysisDeviceGraph({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return SizedBox(
          height: Get.height * controller.analysisHeightFactor,
          child: controller.currentDeviceInAnalysis == null ||
                  controller.deviceAnlysisLogsRx.isEmpty
              ? const Center(
                  child: Text('No data Available for now.'),
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
                                "${log.date.day}-${log.date.hour}:${log.date.minute}:${log.date.second}",
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
      }
    );
  }
}
