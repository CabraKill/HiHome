import 'package:flutter/material.dart';
import 'package:hihome/data/models/device/analogic_device.dart';
import 'package:hihome/data/models/device/onoff_device.dart';
import 'package:hihome/domain/models/device.dart';

enum DeviceType {
  lamp,
  valveOnOff,
  temperature,
  motor,
  waterPump,
  robotArm,
  door,
  generic,
}

dynamic convertDeviceToType(DeviceEntity device) {
  switch (device.type) {
    case DeviceType.lamp:
      return OnOffDevice(device: device);
    case DeviceType.valveOnOff:
      return OnOffDevice(device: device);
    case DeviceType.temperature:
      return AnalogicDevice(device: device);
    case DeviceType.door:
      return OnOffDevice(device: device);
    default:
      return device;
  }
}

extension DeviceTypeExtension on DeviceType {
  String toShortString() {
    return toString().split('.').last;
  }

  bool get isOnOffDevice =>
      this == DeviceType.lamp || this == DeviceType.valveOnOff || this == DeviceType.door;

  Row get stringWithIcon => Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(toShortString()),
          ),
          Icon(
            icon,
            size: 18,
          ),
        ],
      );
  IconData get icon => _getIconFromDevice(this);

  String formattedValue(String value) {
    switch (this) {
      case DeviceType.lamp:
        return value == 'on' ? 'On' : 'Off';
      case DeviceType.valveOnOff:
        return value == 'on' ? 'Open' : 'Closed';
      case DeviceType.temperature:
        return '$value °C';
      case DeviceType.door:
        return value == '1' ? 'Open' : 'Closed';
      default:
        return value;
    }
  }
}

IconData _getIconFromDevice(DeviceType? device) {
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
    case DeviceType.door:
      return Icons.door_back_door;
    default:
      return Icons.smart_toy;
  }
}
