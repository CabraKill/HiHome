import 'package:flutter/material.dart';
import 'package:hihome/data/models/device/device.dart';

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({
    Key? key,
    required this.device,
    required this.offset,
    this.onTap,
  }) : super(key: key);

  final DeviceModel device;
  final Offset offset;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: device.point.y - offset.dy,
      left: device.point.x,
      child: InkWell(
        onTap: onTap,
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
      ),
    );
  }
}
