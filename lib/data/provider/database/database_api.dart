import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hihome/data/helper/connection_erro/auth_error.dart';
import 'package:hihome/data/helper/auth_error/login_exception_handler.dart';
import 'package:hihome/data/helper/connection_erro/connection_exception_error.dart';
import 'package:hihome/data/helper/token_empty_error.dart';
import 'package:hihome/data/models/device/add_device.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/log.dart';
import 'package:hihome/data/models/unit.dart';
import 'package:hihome/data/models/section.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/data/provider/database/database_interface.dart';
import 'package:hihome/data/provider/request/connection_client.dart';
import 'package:hihome/domain/models/add_device.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/device_list_result.dart';
import 'package:hihome/domain/models/device_log.dart';
import 'package:hihome/domain/models/device_log_list_result.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';
import 'package:hihome/utils/firestore_json_converter.dart';

class DataBaseAPI with LoginExceptionHandler implements Database {
  static const baseUrll =
      "https://firestore.googleapis.com/v1/projects/home-dbb7e/databases/(default)";
  // late String token;
  static const key = 'AIzaSyAIdWnqjoG0uo3Z2CYYpB0IHig1CqtLpKA';
  final ConnectionClient connectionClient;

  DataBaseAPI(this.connectionClient);

  @override
  Future<Database> init() async {
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
      useDefaultHeaders: false,
      useDefaultStatusCodeHandlers: false,
    );

    final jsonMap = responseAuth.bodyJson;
    if (responseAuth.statusCode == 400) {
      throw getExceptionType(jsonMap['error']['message']);
    }
    if (responseAuth.statusCode != 200) throw AuthException(responseAuth.body);
    final String token = jsonMap['idToken'];
    if (token.isEmpty) throw TokenEmptyException('token is empty');
    connectionClient.defaultHeaders['Authorization'] = 'Bearer $token';
    final user =
        UserCredentials(id: jsonMap['localId'], name: jsonMap['displayName']);
    return user;
  }

  @override
  Future<UserEntity> getUser(String uid) async {
    final route = '/documents/users/$uid';
    final response = await connectionClient.get(route);
    if (response.statusCode != 200) throw AuthException(response.body);
    final user = UserEntity.fromJson(response.bodyJson);
    return user;
  }

  @override
  Future<UnitEntity> getUnit(String familyId) async {
    final route = "/documents/unities/$familyId";
    final response = await connectionClient.get(route);
    debugPrint(response.body);
    final family = UnitModel.fromJson(response.bodyJson).toEntity();
    return family;
  }

  @override
  Future<DeviceListResult> getDeviceList(String path) async {
    final route = "$path/devices";
    final response = await connectionClient.get(route);
    final deviceList = response.bodyJson['documents']
        .map<DeviceEntity>(
          (json) => DeviceModel.fromJson(json).toEntity(),
        )
        .toList();
    return DeviceListResult(deviceList: deviceList);
  }

  @override
  Future<List<SectionEntity>> getSectionList(String path) async {
    final route = '$path/sections'; //?mask.fieldPaths=name';
    final response = await connectionClient.get(route);
    if (response.bodyJson.isEmpty) return [];
    final houseList = response.bodyJson['documents']
        .map<SectionEntity>(
          (document) => SectionModel.fromJson(
            document..['id'] = (document['name'] as String).split('/').last,
          ).toEntity(),
        )
        .toList();
    return houseList;
  }

  @override
  Future<void> addDevice(AddDeviceEntity device) async {
    final response = await connectionClient.post(
      '${device.path}/devices',
      jsonEncode(
        firestoreJsonConverter(AddDeviceModel.fromEntity(device).toJson()),
      ),
    );
    if (response.statusCode != 200) {
      throw Failure('Unable to add device. Error: ${response.body}');
    }
  }

  @override
  Future<void> updateDeviceDocument(DeviceEntity device) async {
    final deviceJson = DeviceModel.fromEntity(device).toJson();
    final fieldPaths = deviceJson.keys
        .toList()
        .map((key) => 'updateMask.fieldPaths=$key')
        .join('&');
    final firestoreJson = firestoreJsonConverter(deviceJson);
    final url = '${device.path}?$fieldPaths';
    final response = await connectionClient.patch(
      url,
      jsonEncode(firestoreJson),
    );
    if (response.statusCode != 200) throw ConnectionException(response.body);
  }

  @override
  Future<void> removeDevice(DeviceEntity device) async {
    final response = await connectionClient.delete(
      device.path,
    );
    if (response.statusCode != 200) {
      throw Failure('Unable to remove device. Error: ${response.body}');
    }
  }

  @override
  Future<DeviceLogListResult> getDeviceLogList(String path) async {
    final response = await connectionClient.get(
      '$path/logs?pageSize=20&orderBy=time desc',
    );
    final deviceLogList = (response.bodyJson['documents'] ?? [])
        .map<DeviceLogEntity>(
          (document) => DeviceLogModel.fromJson(document).toEntity(),
        )
        .toList();
    return DeviceLogListResult(
      deviceLogList: (deviceLogList as List<DeviceLogEntity>).reversed.toList(),
    );
  }
}
