import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';

abstract class DatabasePlatform {
  ///Init the database dependencies
  Future<DatabasePlatform> init();
  Future<UserModel> login(String email, String password);
  Future<List<HouseModel>> getHomeList();
  Future<List<RoomModel>> getRoomList(String homeId);
  Future<List<DeviceModel>> getDeviceList(String homeId);
}
