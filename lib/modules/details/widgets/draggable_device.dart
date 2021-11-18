import 'package:flutter/material.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';

typedef OnDeviceDragEnd = void Function(DeviceType, DevicePointModel);

class DraggableDevice extends StatelessWidget {
  const DraggableDevice({
    required this.deviceType,
    required this.onDragEnd,
    this.iconData,
    Key? key,
  }) : super(key: key);

  final DeviceType deviceType;
  final IconData? iconData;
  final OnDeviceDragEnd onDragEnd;

  @override
  Widget build(BuildContext context) {
    final icon = iconData ?? deviceType.icon;
    final child = Icon(icon);
    return Draggable(
      child: child,
      feedback: child,
      childWhenDragging: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onDragEnd: (data) {
        final devicePointModel =
            DraggableDevice.dragEndMath(context, data.offset);
        onDragEnd(deviceType, devicePointModel);
      },
    );
  }

  static DevicePointModel dragEndMath(BuildContext context, Offset offset) {
    final height = MediaQuery.of(context).size.height;
    final dx = offset.dx;
    final dy = offset.dy;

    final relativeX = dx / MediaQuery.of(context).size.width;
    final relativeY = (dy / height);
    final devicePointModel = DevicePointModel(
      x: relativeX,
      y: relativeY,
    );
    return devicePointModel;
  }
}
