import 'package:hihome/data/models/house.dart';

class FamilyModel {
  final String documentName;
  final String name;
  List<HouseModel>? houseList;

  FamilyModel({required this.documentName, required this.name, this.houseList});

  FamilyModel.fromJson(Map<String, dynamic> jsonMap)
      : documentName = (jsonMap['name'] as String).split('/').last,
        name = jsonMap['fields']['name']['stringValue'],
        houseList = jsonMap['fields']['houses'] != null
            ? (jsonMap['fields']['houses'] as List<Map<String, dynamic>>)
                .map((house) => HouseModel.fromJson(house))
                .toList()
            : null;
}
