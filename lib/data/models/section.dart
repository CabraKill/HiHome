import 'package:hihome/domain/models/section.dart';
import 'package:hihome/utils/get_path_from_firestore_document_name.dart';

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
        path = pathFromFireStoreDocumentName(json['name']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }

  SectionEntity toEntity() => SectionEntity(id: id, name: name, path: path);
}
