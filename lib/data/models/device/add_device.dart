import 'package:hihome/domain/models/add_device.dart';

import 'device_point.dart';
import 'device_type.dart';

class AddDeviceModel {
  String bruteValue;
  String? name;
  DevicePointModel point;
  DeviceType type;
  final String path;

  AddDeviceModel({
    required this.bruteValue,
    required this.type,
    required this.point,
    required this.path,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = bruteValue;
    data['name'] = name;
    data['point'] = {'x': point.x, 'y': point.y};
    data['type'] = type.toShortString();
    return data;
  }

  AddDeviceModel.fromEntity(AddDeviceEntity device)
      : bruteValue = device.bruteValue,
        name = device.name,
        point = device.point,
        type = device.type,
        path = device.path;
}
