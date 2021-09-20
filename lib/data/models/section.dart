import 'package:hihome/domain/models/section.dart';

class SectionModel {
  late String id;
  late String name;
  //TODO: Add document path

  SectionModel({required this.id, required this.name});

  SectionModel.fromJson(Map<String, dynamic> json)
      //TODO: Improve id search to use name path
      : id = json['id'],
        name = json['name']['stringValue'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }

  SectionEntity toEntity() => SectionEntity(id: id, name: name);
}
