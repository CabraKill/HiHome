import 'dart:io';
import 'package:hihome/data/models/house.dart';
import 'databaseSDK.dart';
import 'database_interface.dart';

class Database implements DatabasePlatform {
  late DatabasePlatform instance;

  Database() {
    instance = platformChooser();
  }

  @override
  init() {
    return instance.init();
  }

  DatabasePlatform platformChooser() {
    if (Platform.isAndroid || Platform.isIOS) return FirestoreSDK();
    throw UnimplementedError("Platform not implemented");
  }

  @override
  Future<List<HouseModel>> getHomeList() {
    return instance.getHomeList();
  }
}
