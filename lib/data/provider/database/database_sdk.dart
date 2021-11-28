import 'package:firebase_auth/firebase_auth.dart';
import 'package:hihome/data/helper/connection_erro/auth_error.dart';
import 'package:hihome/data/helper/auth_error/email_not_found_error.dart';
import 'package:hihome/data/helper/auth_error/invalid_password_error.dart';
import 'package:hihome/data/models/device/add_device.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/log.dart';
import 'package:hihome/data/models/section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/domain/models/add_device.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/device_list_result.dart';
import 'package:hihome/domain/models/device_log.dart';
import 'package:hihome/domain/models/device_log_list_result.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';
import 'package:hihome/utils/get_device_type_from_string.dart';
import 'database_interface.dart';

class FirestoreSDK implements Database {
  late FirebaseFirestore _firestore;
  UserCredential? userCredential;

  @override
  Future<FirestoreSDK> init() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    return this;
  }

  @override
  Future<UserCredentials> login(String email, String password) async {
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw EmailNotFoundException(e.email);
      } else if (e.code == 'wrong-password') {
        throw InvalidPasswordException();
      }
    } catch (e) {
      throw AuthException(e.toString());
    }
    String name = "";
    String id = "";
    if (userCredential!.user != null) {
      if (userCredential!.user!.displayName != null) {
        name = userCredential!.user!.displayName!;
      }
      id = userCredential!.user!.uid;
    }
    final user = UserCredentials(name: name, id: id);
    return user;
  }

  @override
  Future<UnitEntity> getUnit(String familyId) async {
    final unitDocument = await _firestore.doc("unities/$familyId").get();
    final unit = UnitEntity(
      unitId: unitDocument.id,
      name: unitDocument.data()?['name'] ?? '',
      userDelay: unitDocument.data()?['userDelay'] ?? 5000,
      path: unitDocument.reference.path,
    );
    return unit;
  }

  @override
  Future<List<SectionEntity>> getSectionList(String path) async {
    final homeCollection = await _firestore.collection("$path/sections").get();
    final houseCollectionList = homeCollection.docs;
    final houseList = houseCollectionList
        .map<SectionEntity>(
          (document) => SectionModel(
            id: document.id,
            name: document.data()['name'] ?? '',
            path: document.reference.path,
          ).toEntity(),
        )
        .toList();
    return houseList;
  }

  @override
  Future<DeviceListResult> getDeviceList(String path) async {
    //TODO: update path here
    final deviceCollectionRef = _firestore.collection('$path/devices');
    final deviceSnapshot = await deviceCollectionRef.get();
    final deviceCollectionList = deviceSnapshot.docs;
    final deviceList = deviceCollectionList
        .map<DeviceEntity>(
          (document) => DeviceEntity(
            id: document.id,
            name: document.data()['name'] ?? '',
            bruteValue: document.data()['value'] ?? '',
            point: DevicePointModel(
              x: document.data()['point']?['x'] ?? 0.5,
              y: document.data()['point']?['y'] ?? 0.5,
            ),
            type: getDeviceTypeFromText(document.data()['type']),
            path: document.reference.path,
            document: document,
          ),
        )
        .toList();
    return DeviceListResult(
      deviceList: deviceList,
      collectionReference: deviceCollectionRef,
    );
  }

  @override
  Future<UserEntity> getUser(String uid) async {
    final userDocumentRef = _firestore.doc("users/$uid");
    final userDocument = await userDocumentRef.get();
    final user = UserEntity(
      name: userDocument.data()?['name'] ?? '',
      familyId: userDocument.data()?['unitId'],
    );
    return user;
  }

  @override
  Future<void> addDevice(AddDeviceEntity device) async {
    final deviceDocumentRef = _firestore.collection("${device.path}/devices");
    await deviceDocumentRef.add(AddDeviceModel.fromEntity(device).toJson());
  }

  @override
  Future<void> updateDeviceDocument(DeviceEntity device) async {
    final deviceDocumentRef = _firestore.doc(device.path);
    await deviceDocumentRef.update(DeviceModel.fromEntity(device).toJson());
  }

  @override
  Future<void> removeDevice(DeviceEntity device) async {
    final deviceDocumentRef = _firestore.doc(device.path);
    await deviceDocumentRef.delete();
  }

  @override
  Future<DeviceLogListResult> getDeviceLogList(String path) async {
    final deviceCollection = _firestore.collection("$path/logs");
    final deviceCollectionLimited =
        deviceCollection.orderBy('time').limitToLast(20);
    final deviceLogsSnapshot = await deviceCollectionLimited.get();
    final deviceLogList = deviceLogsSnapshot.docs
        .map<DeviceLogEntity>(
          (document) => DeviceLogModel.fromDocument(
            document,
          ).toEntity(),
        )
        .toList();
    return DeviceLogListResult(
        deviceLogList: deviceLogList,
        collectionReference: deviceCollectionLimited);
  }
}
