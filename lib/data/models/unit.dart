import 'package:hihome/data/models/house.dart';

class UnitModel {
  final String familyId;
  final String name;
  List<HouseModel> houseList;

  UnitModel(
      {required this.familyId, required this.name, required this.houseList});

  UnitModel.fromJson(Map<String, dynamic> jsonMap)
      : familyId = (jsonMap['name'] as String).split('/').last,
        name = jsonMap['fields']['name']['stringValue'],
        houseList = jsonMap['fields']['houses'] != null
            ? (jsonMap['fields']['houses'] as List<Map<String, dynamic>>)
                .map((house) => HouseModel.fromJson(house))
                .toList()
            : [];
}
