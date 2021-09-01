class UserModel {
  final String name;
  final String? familyId;

  UserModel({required this.name, this.familyId});

  UserModel.fromJson(Map<String, dynamic> jsonMap)
      : familyId = jsonMap['fieldPaths']['familyId']['stringValue'],
        name = jsonMap['fieldPaths']['name']['stringValue'];
}
