import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hihome/data/models/unit.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/data/provider/request/client_getx.dart';
import 'package:hihome/data/provider/request/connection_client.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/section.dart';
import 'database_api.dart';
import 'database_interface.dart';
import 'database_sdk.dart';

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
  Future<UnitModel> getUnit(String familyId) {
    return instance.getUnit(familyId);
  }

  @override
  Future<List<SectionEntity>> getSectionList(String familyId) {
    return instance.getSectionList(familyId);
  }

  @override
  Future<List<DeviceEntity>> getDeviceList(String path) {
    return instance.getDeviceList(path);
  }

  @override
  Future<List<RoomModel>> getRoomList(String familyId, String homeId) {
    return instance.getRoomList(familyId, homeId);
  }

  @override
  Future<UserEntity> getUser(String uid) {
    return instance.getUser(uid);
  }
}
