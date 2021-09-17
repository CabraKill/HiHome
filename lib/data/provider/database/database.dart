import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/unit.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/data/provider/request/client_getx.dart';
import 'package:hihome/data/provider/request/connection_client.dart';
import 'database_api.dart';
import 'database_sdk.dart';
import 'database_interface.dart';

class DataBase implements DatabasePlatform {
  late DatabasePlatform instance;
  final ConnectionClient connectionClient;

  DataBase(this.connectionClient) {
    instance = platformChooser();
  }

  @override
  Future<DataBase> init() async {
    await instance.init();
    return this;
  }

  @override
  Future<UserCredentials> login(String email, String password) {
    return instance.login(email, password);
  }

  DatabasePlatform platformChooser() {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) return FirestoreSDK();
    //TODO: import this baseUrl from somewhere else
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      return DataBaseAPI(ConnectionClient(
          client: ClientGetX(),
          baseUrl:
              "https://firestore.googleapis.com/v1/projects/home-dbb7e/databases/(default)"));
    }
    throw UnimplementedError("Platform not implemented");
  }

  @override
  Future<UnitModel> getFamily(String familyId) {
    return instance.getFamily(familyId);
  }

  @override
  Future<List<HouseModel>> getHomeList(String familyId) {
    return instance.getHomeList(familyId);
  }

  @override
  Future<List<DeviceModel>> getDeviceList(
      String familyId, String homeId, String roomId) {
    return instance.getDeviceList(familyId, homeId, roomId);
  }

  @override
  Future<List<RoomModel>> getRoomList(String familyId, String homeId) {
    return instance.getRoomList(familyId, homeId);
  }

  @override
  Future<UserModel> getUser(String uid) {
    return instance.getUser(uid);
  }
}
