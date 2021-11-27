import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hihome/domain/models/device.dart';

class DeviceListResult {
  final List<DeviceEntity> deviceList;
  final CollectionReference<Map<String, dynamic>>? collectionReference;

  DeviceListResult({
    required this.deviceList,
    this.collectionReference,
  });
}
