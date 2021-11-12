import 'package:flutter/material.dart';
import 'package:hihome/data/models/device/device_type.dart';

extension DeviceIcon on DeviceType {
  IconData get icon => getIconFromDevice(this);
}

IconData getIconFromDevice(DeviceType? device) {
  switch (device) {
    case DeviceType.lamp:
      return Icons.lightbulb;
    case DeviceType.valveOnOff:
      return Icons.water;
    case DeviceType.temperature:
      return Icons.thermostat;
    case DeviceType.motor:
      return Icons.circle;
    case DeviceType.robotArm:
      return Icons.precision_manufacturing;
    case DeviceType.waterPump:
      return Icons.water;
    default:
      return Icons.smart_toy;
  }
}
