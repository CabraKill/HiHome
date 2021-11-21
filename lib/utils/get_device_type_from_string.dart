import 'package:hihome/data/models/device/device_type.dart';

DeviceType getDeviceTypeFromText(String? typeString) {
  final icons = <String, DeviceType>{};
  for (var type in DeviceType.values) {
    icons[type.toShortString()] = type;
  }
  return icons[typeString] ?? DeviceType.generic;
}
