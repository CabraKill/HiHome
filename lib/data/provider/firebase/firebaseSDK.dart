import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/provider/firebase/firebase_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSDK implements FireBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<HouseModel>> getHomeList() async {
    // TODO: implement getHomeList
    final homeCollection = _firestore.collection("/houses");
    final houseList = homeCollection.parameters.values
        .map<HouseModel>((document) =>
            HouseModel(id: document['id'], name: document['name']))
        .toList();
    return houseList;
  }
}
