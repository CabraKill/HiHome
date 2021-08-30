import 'package:hihome/data/helper/auth_error.dart';
import 'package:hihome/data/helper/tokenEmpty_error.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/loginResult.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/provider/database/database_interface.dart';
import 'package:hihome/data/provider/request/connectionClient.dart';

class DataBaseAPI implements DatabasePlatform {
  static const baseUrll =
      "https://firestore.googleapis.com/v1/projects/home-dbb7e/databases/(default)";
  // late String token;
  static const key = 'AIzaSyAIdWnqjoG0uo3Z2CYYpB0IHig1CqtLpKA';
  final ConnectionClient connectionClient;

  DataBaseAPI(this.connectionClient);

  @override
  Future<DatabasePlatform> init() async {
    return this;
  }

  @override
  Future<LoginResult> login(String email, String password) async {
    try {
      final responseAuth = await connectionClient.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$key',
          '{"email": "$email","password": "$password","returnSecureToken": true}',
          headers: {'Content-Type': 'application/json'},
          useBaseUrl: false,
          useDefaultHeaders: false);
      final jsonMap = responseAuth.bodyJson;
      if (responseAuth.statusCode == 400)
        throw AuthException(jsonMap['error']['message']);
      final String token = jsonMap['idToken'];
      if (token.isEmpty) throw TokenEmptyException('token is empty');
      connectionClient.defaultHeaders['Authorization'] = 'Bearer $token';
      return LoginResult(token);
    } on AuthException {
      rethrow;
    } on TokenEmptyException {
      rethrow;
    } catch (error) {
      rethrow;
      //TODO: fix the timeout exception
    }
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
    final response =
        await connectionClient.get('/documents/houses/$homeId/rooms');
    final roomList = response.bodyJson['documents']
        .map<RoomModel>((document) => RoomModel.fromJson(document))
        .toList();
    return roomList;
  }
}
