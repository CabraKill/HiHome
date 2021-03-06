import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/domain/models/device_log.dart';
import 'package:hihome/utils/get_device_type_from_string.dart';

class DeviceLogModel extends DeviceLogEntity {
  DeviceLogModel({
    required String name,
    required DeviceType type,
    required String value,
    required DateTime date,
  }) : super(
          name: name,
          type: type,
          value: value,
          date: date,
        );

  DeviceLogModel.fromJson(Map<String, dynamic> json)
      : super(
          name: json['fields']['name']?['stringValue'] ?? '',
          type: getDeviceTypeFromText(json['fields']['type']?['stringValue']),
          value: json['fields']['value']?['stringValue'] ?? '',
          date: DateTime.parse(
            json['fields']['time']?['timestampValue'] ?? '',
          ),
        );

  DeviceLogModel.fromDocument(document)
      : super(
          name: document.data()['name'] ?? '',
          type: getDeviceTypeFromText(document.data()['type']),
          value: document.data()['value'] ?? '',
          date: (document.data()['time'] as Timestamp?)?.toDate() ??
              DateTime.now(),
        );

  DeviceLogEntity toEntity() {
    return DeviceLogEntity(
      name: name,
      type: type,
      value: value,
      date: date,
    );
  }
}
