import 'package:hihome/data/models/unit.dart';
import 'package:hihome/data/models/section.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/domain/models/device.dart';

abstract class DatabasePlatform {
  ///Init the database dependencies
  Future<DatabasePlatform> init();
  Future<UserCredentials> login(String email, String password);
  Future<UserEntity> getUser(String uid);
  Future<UnitModel> getUnit(String familyId);
  Future<List<SectionModel>> getHomeList(String familyId);
  Future<List<RoomModel>> getRoomList(String familyId, String homeId);
  Future<List<DeviceEntity>> getDeviceList(String path);
}
