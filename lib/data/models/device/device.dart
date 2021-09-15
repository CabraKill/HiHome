import 'package:hihome/data/models/device/device_point.dart';

class DeviceModel {
  final String id;
  final String state;
  final String name;
  final DevicePointModel point;

  DeviceModel(
      {required this.id,
      required this.name,
      required this.state,
      required this.point});

  DeviceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        state = json['state'],
        point = json['point'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state'] = state;
    data['name'] = name;
    data['point'] = point;
    return data;
  }
}
