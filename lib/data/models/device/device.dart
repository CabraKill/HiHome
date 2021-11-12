import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/domain/models/device.dart';

class DeviceModel {
  final String id;
  final String value;
  final String? name;
  final DevicePointModel? point;
  final String type;
  dynamic document;

  DeviceModel({
    required this.id,
    required this.name,
    required this.value,
    required this.point,
    required this.type,
  });

  DeviceModel.fromJson(Map<String, dynamic> json)
      : id = (json['name'] as String).split('/').last,
        name = json['fields']['name']?['stringValue'],
        value = json['fields']['value']?['stringValue'],
        point = getPointFromJson(json['fields']['point']),
        type = json['fields']['type']?['stringValue'] ?? 'generic',
        //TODO: evaluate if this is the best way to get the document or passe above the fields
        document = json['fields'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['name'] = name;
    data['point'] = point;
    return data;
  }

  DeviceEntity toEntity() => DeviceEntity(
        id: id,
        name: name,
        bruteValue: value,
        point: point,
        type: getTypeFromText(type),
      );

  DeviceModel.fromEntity(DeviceEntity entity)
      : id = entity.id,
        name = entity.name,
        value = entity.bruteValue,
        point = entity.point,
        type = entity.type.toString();

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

  DeviceType getTypeFromText(String type) {
    switch (type) {
      case 'lamp':
        return DeviceType.lamp;
      case 'valve_onoff':
        return DeviceType.valveOnOff;
      default:
        return DeviceType.generic;
    }
  }
}
