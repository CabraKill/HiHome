import 'package:flutter/material.dart';
import 'package:hihome/data/models/device/device.dart';

class DeviceWidget extends StatelessWidget {
  final DeviceModel device;
  final Offset offset;

  const DeviceWidget({Key? key, required this.device, required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: device.point.y - offset.dy,
      left: device.point.x,
      child: Draggable(
        feedback: Container(),
        child: const Icon(Icons.lightbulb),
        onDragEnd: (details) {
          device.point.x = details.offset.dx;
          device.point.y = details.offset.dy -
              MediaQuery.of(context).padding.top -
              offset.dy;
        },
      ),
    );
  }
}
