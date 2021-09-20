import 'package:hihome/domain/models/section.dart';

class UnitEntity {
  final String familyId;
  final String name;
  List<SectionEntity> houseList;

  UnitEntity(
      {required this.familyId, required this.name, required this.houseList});
}
