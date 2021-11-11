import 'package:flutter/material.dart';
import 'package:hihome/data/models/device/device_type.dart';

extension DeviceIcon on DeviceType {
  IconData get icon => getIconFromDevice(this);
}

IconData getIconFromDevice(DeviceType? device) {
  switch (device) {
    case DeviceType.lamp:
      return Icons.lightbulb;
    case DeviceType.motor:
      return Icons.circle;
    case DeviceType.robotArm:
      return Icons.precision_manufacturing;
    case DeviceType.valve:
      return Icons.water;
    case DeviceType.waterPump:
      return Icons.water;
    default:
      return Icons.check_box_outline_blank_rounded;
  }
}
