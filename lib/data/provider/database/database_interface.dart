import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/room.dart';

abstract class DatabasePlatform {
  Future<DatabasePlatform> init();
  Future<List<HouseModel>> getHomeList();
  Future<List<RoomModel>> getRoomList(String homeId);
  Future<List<DeviceModel>> getDeviceList(String homeId);
}
