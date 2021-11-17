import 'package:flutter/material.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/data/models/device/onoff_device.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/modules/details/widgets/draggable_device.dart';

typedef OnUpdateDeviceDragEnd = void Function(DevicePointModel);

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({
    Key? key,
    required this.device,
    required this.offset,
    required this.onDeviceDragEnd,
    this.onTap,
  }) : super(key: key);

  final DeviceEntity device;
  final Offset offset;
  final OnUpdateDeviceDragEnd onDeviceDragEnd;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // print("h: ${MediaQuery.of(context).size.height}");
    // print("w: ${MediaQuery.of(context).size.width}");
    final topPadding = relativeHeightValue(context) +
        (device.point?.y == 0.5 ? 0 : iconHeightPadding(context));
    final leftPadding = relativeWidthValue() +
        (device.point?.y == 0.5 ? 0 : iconLeftPadding(context));
    final on = (device.type == DeviceType.lamp)
        ? OnOffDevice(device: device).value
        : null;
    final iconWidget = Icon(
      icon,
      color: on == true ? Colors.cyan : null,
    );
    return Align(
      alignment: Alignment(
        leftPadding,
        topPadding,
      ),
      child: InkWell(
        onTap: onTap,
        child: Draggable(
          feedback: iconWidget,
          child: iconWidget,
          onDragEnd: (details) {
            final point = DraggableDevice.dragEndMath(context, details.offset);
            onDeviceDragEnd(point);
          },
        ),
      ),
    );
  }

  IconData get icon => device.type.icon;

  double absoluteHeightValue(BuildContext context, double? relative) =>
      (relative ?? 0) * MediaQuery.of(context).size.height;

  double absoluteWidthValue(BuildContext context, double? relative) =>
      (relative ?? 0) * MediaQuery.of(context).size.width;

  double relativeHeightValue(BuildContext context) {
    final offSetFactor = offset.dy / MediaQuery.of(context).size.height;
    final factor = (device.point?.y ?? 0) - offSetFactor;
    final newRange = newRangeFromFactor(factor);
    return newRange;
  }

  double relativeWidthValue() {
    final factor = device.point?.x ?? 0;
    final newRange = newRangeFromFactor(factor);
    return newRange;
  }

  double iconLeftPadding(BuildContext context) {
    return 25 / MediaQuery.of(context).size.width;
  }

  double iconHeightPadding(BuildContext context) {
    return 70 / MediaQuery.of(context).size.height;
  }

  double newRangeFromFactor(double factor) {
    final newRange = (2 * factor) - 1;
    return newRange;
  }
}
