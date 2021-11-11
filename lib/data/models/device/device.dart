import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/domain/models/device.dart';

class DeviceModel {
  final String id;
  final String? state;
  final String? name;
  final DevicePointModel? point;

  DeviceModel({
    required this.id,
    required this.name,
    required this.state,
    required this.point,
  });

  DeviceModel.fromJson(Map<String, dynamic> json)
      : id = (json['name'] as String).split('/').last,
        name = json['fields']['name']?['stringValue'],
        state = json['fields']['state']?['stringValue'],
        point = getPointFromJson(json['fields']['point']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state'] = state;
    data['name'] = name;
    data['point'] = point;
    return data;
  }

  DeviceEntity toEntity() =>
      DeviceEntity(id: id, name: name, bruteState: state, point: point);

  DeviceModel.fromEntity(DeviceEntity entity)
      : id = entity.id,
        name = entity.name,
        state = entity.bruteState,
        point = entity.point;

  static DevicePointModel? getPointFromJson(Map<String, dynamic>? json) {
    final double? x = getValueFromJson(json?['mapValue']['fields']['x']);
    final double? y = getValueFromJson(json?['mapValue']['fields']['y']);
    if (x == null || y == null) {
      return null;
    }
    return DevicePointModel(
      x: x,
      y: y,
    );
  }

  //return integerValue or doubleValue from document in firestore
  static dynamic getValueFromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    return json['integerValue'] != null
        ? double.parse(json['integerValue'])
        : json['doubleValue'];
  }
}
