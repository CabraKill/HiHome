class UserModel {
  final String name;
  final String? familyId;

  UserModel({required this.name, this.familyId});

  UserModel.fromJson(Map<String, dynamic> jsonMap)
      : familyId = jsonMap['fields']['familyId']['stringValue'],
        name = jsonMap['fields']['name']['stringValue'];
}
