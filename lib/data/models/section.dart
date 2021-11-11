import 'package:hihome/domain/models/section.dart';

class SectionModel {
  final String id;
  final String name;
  final String path;
  //TODO: Add document path

  SectionModel({required this.id, required this.name, required this.path});

  SectionModel.fromJson(Map<String, dynamic> json)
      //TODO: Improve id search to use name path
      : id = json['id'],
        name = json['fields']['name']['stringValue'],
        path = '/' + (json['name'] as String).split('/').sublist(4).join('/');

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }

  SectionEntity toEntity() => SectionEntity(id: id, name: name, path: path);
}
