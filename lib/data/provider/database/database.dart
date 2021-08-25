import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/house.dart';
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

  DatabasePlatform platformChooser() {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) return FirestoreSDK();
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS)
      return DataBaseAPI();
    throw UnimplementedError("Platform not implemented");
  }

  @override
  Future<List<HouseModel>> getHomeList() {
    return instance.getHomeList();
  }

  @override
  Future<List<DeviceModel>> getDeviceList(String homeId) {
    return instance.getDeviceList(homeId);
  }
}
