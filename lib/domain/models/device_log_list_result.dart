import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hihome/domain/models/device_log.dart';

class DeviceLogListResult {
  final List<DeviceLogEntity> deviceLogList;
  final Query<Map<String, dynamic>>? collectionReference;

  DeviceLogListResult({
    required this.deviceLogList,
    this.collectionReference,
  });
}
