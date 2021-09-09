import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/family.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/userCredentials.dart';
import 'package:hihome/data/provider/request/clientGetX.dart';
import 'package:hihome/data/provider/request/connectionClient.dart';
import 'databaseAPI.dart';
import 'databaseSDK.dart';
import 'database_interface.dart';

class DataBase implements DatabasePlatform {
  late DatabasePlatform instance;

  DataBase() {
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
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS)
      return DataBaseAPI(ConnectionClient(
          client: ClientGetX(),
          baseUrl:
              "https://firestore.googleapis.com/v1/projects/home-dbb7e/databases/(default)"));
    throw UnimplementedError("Platform not implemented");
  }

  @override
  Future<FamilyModel> getFamily(String familyId) {
    return instance.getFamily(familyId);
  }

  @override
  Future<List<HouseModel>> getHomeList(String familyId) {
    return instance.getHomeList(familyId);
  }

  @override
  Future<List<DeviceModel>> getDeviceList(String homeId) {
    return instance.getDeviceList(homeId);
  }

  @override
  Future<List<RoomModel>> getRoomList(String homeId) {
    return instance.getRoomList(homeId);
  }

  @override
  Future<UserModel> getUser(String uid) {
    return instance.getUser(uid);
  }
}
