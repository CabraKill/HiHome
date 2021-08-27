import 'package:get/get_connect.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/provider/database/database_interface.dart';
import 'package:hihome/data/provider/request/connectionClient.dart';

class DataBaseAPI extends GetConnect implements DatabasePlatform {
  static const baseUrll =
      "https://firestore.googleapis.com/v1/projects/home-dbb7e/databases/(default)";
  // late String token;
  static const key = 'AIzaSyAIdWnqjoG0uo3Z2CYYpB0IHig1CqtLpKA';
  final ConnectionClient connectionClient;

  DataBaseAPI(this.connectionClient);

  @override
  Future<DatabasePlatform> init() async {
    //TODO: remove this login hard coded
    final responseAuth = await post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$key',
        '{"email": "raphaeldesouza@outlook.com","password":"123456","returnSecureToken": true}',
        headers: {'Content-Type': 'application/json'});
    final jsonMap = responseAuth.body;
    final String token = jsonMap['idToken'];
    connectionClient.defaultHeaders['Authorization'] = 'Bearer $token';
    return this;
  }

  @override
  Future<List<DeviceModel>> getDeviceList(String homeId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<HouseModel>> getHomeList() async {
    final route = "/documents/houses?mask.fieldPaths=name";
    final response = await connectionClient.get(route);
    final houseList = response.bodyJson['documents']
        .map<HouseModel>((document) => HouseModel.fromJson(document['fields']
          ..['id'] = (document['name'] as String).split('/').last))
        .toList();
    return houseList;
  }

  @override
  Future<List<RoomModel>> getRoomList(String homeId) async {
    // final response = connectionClient.get('/documents/$homeId/rooms');
    throw UnimplementedError();
  }
}
