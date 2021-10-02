import 'package:hihome/domain/models/device.dart';

class SectionEntity {
  final String id;
  final String name;
  final String path;
  late List<DeviceEntity>? deviceList;

  SectionEntity(
      {required this.id,
      required this.name,
      required this.path,
      this.deviceList});
}
