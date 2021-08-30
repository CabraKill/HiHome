import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/loginResult.dart';
import 'package:hihome/data/models/room.dart';

abstract class DatabasePlatform {
  ///Init the database dependencies
  Future<DatabasePlatform> init();
  Future<Either<Failure, LoginResult>> login(String email, String password);
  Future<List<HouseModel>> getHomeList();
  Future<List<RoomModel>> getRoomList(String homeId);
  Future<List<DeviceModel>> getDeviceList(String homeId);
}
