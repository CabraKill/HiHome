import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/utils/get_device_type_from_string.dart';
import 'package:hihome/utils/get_path_from_firestore_document_name.dart';

class DeviceModel {
  final String id;
  final String bruteValue;
  final String name;
  final DevicePointModel point;
  final DeviceType type;
  final String path;
  dynamic document;

  DeviceModel({
    required this.id,
    required this.name,
    required this.bruteValue,
    required this.point,
    required this.type,
    required this.path,
  });

  DeviceModel.fromJson(Map<String, dynamic> json)
      : id = (json['name'] as String).split('/').last,
        name = json['fields']['name']?['stringValue'],
        bruteValue = json['fields']['value']?['stringValue'] ?? '',
        point = getPointFromJson(json['fields']['point']) ??
            DevicePointModel(x: 0.5, y: 0.5),
        type = getDeviceTypeFromText(json['fields']['type']?['stringValue']),
        path = pathFromFireStoreDocumentName(json['name']),
        //TODO: evaluate if this is the best way to get the document or passe above the fields
        document = json['fields'];

  DeviceModel.fromDocument(this.document)
      : id = document.id,
        name = document.data()['name'] ?? '',
        bruteValue = document.data()['value'] ?? '',
        point = DevicePointModel(
          x: getValueAsDouble(document.data()['point']?['x']) ?? 0.5,
          y: getValueAsDouble(document.data()['point']?['y']) ?? 0.5,
        ),
        type = getDeviceTypeFromText(document.data()['type']),
        path = document.reference.path;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = bruteValue;
    data['name'] = name;
    data['point'] = point.toJson();
    return data;
  }

  DeviceEntity toEntity() => DeviceEntity(
        id: id,
        name: name,
        bruteValue: bruteValue,
        point: point,
        type: type,
        path: path,
        document: document,
      );

  DeviceModel.fromEntity(DeviceEntity entity)
      : id = entity.id,
        name = entity.name,
        bruteValue = entity.bruteValue,
        point = entity.point,
        type = entity.type,
        path = entity.path;

  static DevicePointModel? getPointFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    final double? x = getValueFromJson(json['mapValue']['fields']['x']);
    final double? y = getValueFromJson(json['mapValue']['fields']['y']);
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

  static double? getValueAsDouble(value) {
    if (value is int) return value.toDouble();
    return value;
  }
}
