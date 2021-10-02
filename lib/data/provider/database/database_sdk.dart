import 'package:firebase_auth/firebase_auth.dart';
import 'package:hihome/data/helper/connection_erro/auth_error.dart';
import 'package:hihome/data/helper/auth_error/email_not_found_error.dart';
import 'package:hihome/data/helper/auth_error/invalid_password_error.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/unit.dart';
import 'package:hihome/data/models/section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/domain/models/device.dart';
import 'database_interface.dart';

class FirestoreSDK implements DatabasePlatform {
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
  Future<UnitModel> getUnit(String familyId) {
    // TODO: implement getFamilyList
    throw UnimplementedError();
  }

  @override
  Future<List<SectionModel>> getHomeList(String familyId) async {
    final homeCollection =
        await _firestore.collection("families/$familyId/houses").get();
    final houseCollectionList = homeCollection.docs;
    final houseList = houseCollectionList
        .map<SectionModel>((document) => SectionModel(
            id: document.id, name: document['name'], path: document['path']))
        .toList();
    return houseList;
  }

  @override
  Future<List<DeviceEntity>> getDeviceList(String path) async {
    //TODO: update path here
    final deviceCollectionRef = await _firestore.collection(path).get();
    final deviceCollectionList = deviceCollectionRef.docs;
    final deviceList = deviceCollectionList
        .map<DeviceEntity>((document) => DeviceEntity(
            id: document.id,
            name: document['name'],
            state: document['state'],
            point: DevicePointModel(
                x: document['point']['x'], y: document['point']['x'])))
        .toList();
    return deviceList;
  }

  @override
  Future<List<RoomModel>> getRoomList(String familyId, String homeId) {
    // TODO: implement getRoomList
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> getUser(String uid) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
