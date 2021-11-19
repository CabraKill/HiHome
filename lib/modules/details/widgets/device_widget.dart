import 'package:flutter/material.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/data/models/device/onoff_device.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/modules/details/models/zoom_type.dart';
import 'package:hihome/modules/details/widgets/draggable_device.dart';

typedef OnUpdateDeviceDragEnd = void Function(DevicePointModel);

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({
    Key? key,
    required this.device,
    required this.offset,
    required this.onDeviceDragEnd,
    this.zoomType = DeviceZoomType.normal,
    this.dragEnabled = false,
    this.titleEnable = false,
    this.onTap,
  }) : super(key: key);

  final DeviceEntity device;
  final Offset offset;
  final OnUpdateDeviceDragEnd onDeviceDragEnd;
  final DeviceZoomType zoomType;
  final GestureTapCallback? onTap;
  final bool dragEnabled;
  final bool titleEnable;

  @override
  Widget build(BuildContext context) {
    final topPadding = relativeHeightValue(context) +
        (device.point.y == 0.5 ? 0 : iconHeightPadding(context));
    final leftPadding = relativeWidthValue() +
        (device.point.y == 0.5 ? 0 : iconLeftPadding(context));
    final on =
        (device.type.isOnOffDevice) ? OnOffDevice(device: device).value : null;
    final iconWidget = Icon(
      icon,
      color: on == true ? Colors.cyan : null,
      size: zoomType == DeviceZoomType.normal
          ? null
          : (IconTheme.of(context).size ?? 24) * zoomType.factor,
    );
    final child = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (titleEnable) Text(device.name),
        iconWidget,
        Text(formattedValue(device)),
      ],
    );
    return Align(
      alignment: Alignment(
        leftPadding,
        topPadding,
      ),
      child: InkWell(
        onTap: onTap,
        child: dragEnabled
            ? Draggable(
                feedback: iconWidget,
                child: child,
                onDragEnd: (details) {
                  final point =
                      DraggableDevice.dragEndMath(context, details.offset);
                  onDeviceDragEnd(point);
                },
              )
            : child,
      ),
    );
  }

  String formattedValue(DeviceEntity device) =>
      device.type.formattedValue(device.bruteValue);

  IconData get icon => device.type.icon;

  double absoluteHeightValue(BuildContext context, double? relative) =>
      (relative ?? 0) * MediaQuery.of(context).size.height;

  double absoluteWidthValue(BuildContext context, double? relative) =>
      (relative ?? 0) * MediaQuery.of(context).size.width;

  double relativeHeightValue(BuildContext context) {
    final offSetFactor = offset.dy / MediaQuery.of(context).size.height;
    final factor = device.point.y - offSetFactor;
    final newRange = newRangeFromFactor(factor);
    return newRange;
  }

  double relativeWidthValue() {
    final factor = device.point.x;
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
