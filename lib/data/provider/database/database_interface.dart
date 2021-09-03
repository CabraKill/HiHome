import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/family.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/userCredentials.dart';

abstract class DatabasePlatform {
  ///Init the database dependencies
  Future<DatabasePlatform> init();
  Future<UserCredentials> login(String email, String password);
  Future<UserModel> getUser(String uid);
  Future<FamilyModel> getFamily(String familyId);
  Future<List<HouseModel>> getHomeList();
  Future<List<RoomModel>> getRoomList(String homeId);
  Future<List<DeviceModel>> getDeviceList(String homeId);
}
