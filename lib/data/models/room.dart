import 'device/device.dart';

class RoomModel {
  String id;
  String name;
  List<DeviceModel>? deviceList;

  RoomModel({required this.id, required this.name, this.deviceList});

  RoomModel.fromJson(Map<String, dynamic> json)
      : id = (json['name'] as String).split('/').last,
        name = json['fields']['name']['stringValue'];

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
