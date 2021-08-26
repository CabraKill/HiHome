import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/provider/database/database_interface.dart';

class DataBaseAPI extends GetConnect implements DatabasePlatform {
  static const baseUrll =
      "https://firestore.googleapis.com/v1/projects/home-dbb7e/databases/(default)";
  late String token;
  static const key = 'AIzaSyBSHy46Cn5RRlP3qcuwwsCzXsP1PYVhApo';

  @override
  Future<DatabasePlatform> init() async {
    final responseAuth = await post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$key',
        '{"email": "raphaeldesouza@outlook.com","password":"123456","returnSecureToken": true}',
        headers: {'Content-Type': 'application/json'});
    final jsonMap = responseAuth.body;
    token = jsonMap['idToken'];
    return this;
  }

  @override
  Future<List<DeviceModel>> getDeviceList(String homeId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<HouseModel>> getHomeList() async {
    final url = baseUrll + "/documents/houses?mask.fieldPaths=name";
    final response =
        await get(url, headers: {'Authorization': 'Bearer $token'});
    final houseList = response.body['documents']
        .map<HouseModel>((document) => HouseModel.fromJson(document['fields']
          ..['id'] = (document['name'] as String).split('/').last))
        .toList();
    return houseList;
  }
}
