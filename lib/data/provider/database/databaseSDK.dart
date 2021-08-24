import 'package:hihome/data/models/house.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'database_interface.dart';

class FirestoreSDK implements DatabasePlatform {
  late FirebaseFirestore _firestore;

  @override
  Future<FirestoreSDK> init() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    return this;
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
}
