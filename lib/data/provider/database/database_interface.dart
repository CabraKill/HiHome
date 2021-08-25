import 'package:hihome/data/models/device.dart';
import 'package:hihome/data/models/house.dart';

abstract class DatabasePlatform {
  Future<DatabasePlatform> init();
  Future<List<HouseModel>> getHomeList();
  Future<List<DeviceModel>> getDeviceList(String homeId);
}
