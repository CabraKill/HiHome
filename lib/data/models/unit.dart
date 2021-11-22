import 'package:hihome/data/models/section.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';

class UnitModel {
  final String familyId;
  final String name;
  final String path;
  List<SectionModel>? houseList;

  UnitModel({
    required this.familyId,
    required this.name,
    required this.path,
    required this.houseList,
  });

  UnitModel.fromJson(Map<String, dynamic> jsonMap)
      : familyId = (jsonMap['name'] as String).split('/').last,
        name = jsonMap['fields']['name']['stringValue'],
        path =
            '/' + (jsonMap['name'] as String).split('/').sublist(4).join('/'),
        houseList = jsonMap['fields']['houses'] != null
            ? (jsonMap['fields']['houses'] as List<Map<String, dynamic>>)
                .map((house) => SectionModel.fromJson(house))
                .toList()
            : [];

  UnitEntity toEntity() => UnitEntity(
        familyId: familyId,
        name: name,
        path: path,
        sectionList:
            houseList?.map<SectionEntity>((house) => house.toEntity()).toList(),
      );
}
