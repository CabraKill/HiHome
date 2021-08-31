import 'package:firebase_auth/firebase_auth.dart';
import 'package:hihome/data/helper/auth_error/auth_error.dart';
import 'package:hihome/data/helper/auth_error/emailNotFound_error.dart';
import 'package:hihome/data/helper/auth_error/invalidPassword_error.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/device/devicePoint.dart';
import 'package:hihome/data/models/house.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
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
  Future<UserModel> login(String email, String password) async {
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
      if (userCredential!.user!.displayName != null)
        name = userCredential!.user!.displayName!;
      id = userCredential!.user!.uid;
    }
    final user = UserModel(name: name, id: id);
    return user;
  }

  @override
  Future<List<HouseModel>> getHomeList() async {
    final homeCollection = await _firestore.collection("houses").get();
    final houseCollectionList = homeCollection.docs;
    final houseList = houseCollectionList
        .map<HouseModel>(
            (document) => HouseModel(id: document.id, name: document['name']))
        .toList();
    return houseList;
  }

  @override
  Future<List<DeviceModel>> getDeviceList(String homeId) async {
    final deviceCollectionRef =
        await _firestore.collection("houses/$homeId/devices").get();
    final deviceCollectionList = deviceCollectionRef.docs;
    final deviceList = deviceCollectionList
        .map<DeviceModel>((document) => DeviceModel(
            id: document.id,
            name: document['name'],
            state: document['state'],
            point: DevicePointModel(
                x: document['point']['x'], y: document['point']['x'])))
        .toList();
    return deviceList;
  }

  @override
  Future<List<RoomModel>> getRoomList(String homeId) {
    // TODO: implement getRoomList
    throw UnimplementedError();
  }
}
