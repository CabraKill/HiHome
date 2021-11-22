import 'package:hihome/domain/models/section.dart';

class UnitEntity {
  final String unitId;
  final String name;
  final int userDelay;
  final String path;
  List<SectionEntity>? sectionList;

  UnitEntity({
    required this.unitId,
    required this.name,
    required this.userDelay,
    required this.path,
    this.sectionList,
  });
}
