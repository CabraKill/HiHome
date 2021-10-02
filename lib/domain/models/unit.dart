import 'package:hihome/domain/models/section.dart';

class UnitEntity {
  final String familyId;
  final String name;
  final String path;
  List<SectionEntity>? houseList;

  UnitEntity({
    required this.familyId,
    required this.name,
    required this.path,
    this.houseList,
  });
}
