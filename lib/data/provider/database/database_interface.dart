import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/domain/models/add_device.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/device_list_result.dart';
import 'package:hihome/domain/models/device_log_list_result.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';

abstract class Database {
  ///Init the database dependencies
  Future<Database> init();
  Future<UserCredentials> login(String email, String password);
  Future<UserEntity> getUser(String uid);
  Future<UnitEntity> getUnit(String familyId);
  Future<List<SectionEntity>> getSectionList(String familyId);
  Future<DeviceListResult> getDeviceList(String path);
  Future<void> addDevice(AddDeviceEntity device);
  Future<void> updateDeviceDocument(DeviceEntity device);
  Future<void> removeDevice(DeviceEntity device);
  Future<DeviceLogListResult> getDeviceLogList(String path);
}
