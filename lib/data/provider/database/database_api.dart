import 'package:hihome/data/helper/connection_erro/auth_error.dart';
import 'package:hihome/data/helper/auth_error/login_exception_handler.dart';
import 'package:hihome/data/helper/token_empty_error.dart';
import 'package:hihome/data/models/family.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/data/provider/database/database_interface.dart';
import 'package:hihome/data/provider/request/connection_client.dart';

class DataBaseAPI with LoginExceptionHandler implements DatabasePlatform {
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

  //TODO: receive a model and create a toJson
  @override
  Future<UserCredentials> login(String email, String password) async {
    final responseAuth = await connectionClient.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$key',
        '{"email": "$email","password": "$password","returnSecureToken": true}',
        headers: {'Content-Type': 'application/json'},
        useBaseUrl: false,
        useDefaultHeaders: false);

    final jsonMap = responseAuth.bodyJson;
    if (responseAuth.statusCode == 400)
      throw getExceptionType(jsonMap['error']['message']);
    if (responseAuth.statusCode != 200) throw AuthException(responseAuth.body);
    final String token = jsonMap['idToken'];
    if (token.isEmpty) throw TokenEmptyException('token is empty');
    connectionClient.defaultHeaders['Authorization'] = 'Bearer $token';
    final user =
        UserCredentials(id: jsonMap['localId'], name: jsonMap['displayName']);
    return user;
  }

  @override
  Future<UserModel> getUser(String uid) async {
    final route = '/documents/users/$uid';
    final response = await connectionClient.get(route);
    if (response.statusCode != 200) throw AuthException(response.body);
    final user = UserModel.fromJson(response.bodyJson);
    return user;
  }

  @override
  Future<FamilyModel> getFamily(String familyId) async {
    final route = "/documents/families/$familyId";
    final response = await connectionClient.get(route);
    print(response.body);
    final family = FamilyModel.fromJson(response.bodyJson);
    return family;
  }

  @override
  Future<List<DeviceModel>> getDeviceList(
      String familyId, String homeId, String roomId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<HouseModel>> getHomeList(String familyId) async {
    final route =
        '/documents/families/$familyId/houses'; //?mask.fieldPaths=name';
    final response = await connectionClient.get(route);
    final houseList = response.bodyJson['documents']
        .map<HouseModel>((document) => HouseModel.fromJson(document['fields']
          ..['id'] = (document['name'] as String).split('/').last))
        .toList();
    return houseList;
  }

  @override
  Future<List<RoomModel>> getRoomList(String familyId, String homeId) async {
    final response = await connectionClient
        .get('/documents/families/$familyId/houses/$homeId/rooms');
    final roomList = (response.bodyJson['documents'] ?? [])
        .map<RoomModel>((document) => RoomModel.fromJson(document))
        .toList();
    return roomList;
  }
}
