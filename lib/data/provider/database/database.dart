import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/data/provider/request/client_getx.dart';
import 'package:hihome/data/provider/request/connection_client.dart';
import 'package:hihome/domain/models/add_device.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/device_log.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';
import 'database_api.dart';
import 'database_interface.dart';
import 'database_sdk.dart';

class DataBaseManager implements Database {
  late Database instance;
  final ConnectionClient connectionClient;

  DataBaseManager(this.connectionClient) {
    instance = platformChooser();
  }

  @override
  Future<DataBaseManager> init() async {
    await instance.init();
    return this;
  }

  @override
  Future<UserCredentials> login(String email, String password) {
    return instance.login(email, password);
  }

  Database platformChooser() {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) return FirestoreSDK();
    //TODO: import this baseUrl from somewhere else
    if (Platform.isLinux || Platform.isWindows) {
      return DataBaseAPI(
        ConnectionClient(
          client: ClientGetX(),
          baseUrl:
              "https://firestore.googleapis.com/v1/projects/home-dbb7e/databases/(default)",
        ),
      );
    }

    throw UnimplementedError("Platform not implemented");
  }

  @override
  Future<UnitEntity> getUnit(String familyId) {
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
  Future<UserEntity> getUser(String uid) {
    return instance.getUser(uid);
  }

  @override
  Future<void> addDevice(AddDeviceEntity device) async {
    return instance.addDevice(device);
  }

  @override
  Future<void> updateDeviceDocument(DeviceEntity device) {
    return instance.updateDeviceDocument(device);
  }

  @override
  Future<void> removeDevice(DeviceEntity device) {
    return instance.removeDevice(device);
  }

  @override
  Future<List<DeviceLogEntity>> getDeviceLogList(String path) {
    return instance.getDeviceLogList(path);
  }
}
