class UserEntity {
  final String name;
  final String? familyId;

  UserEntity({required this.name, this.familyId});

  UserEntity.fromJson(Map<String, dynamic> jsonMap)
      : familyId = jsonMap['fields']['unitId']['stringValue'],
        name = jsonMap['fields']['name']['stringValue'];
}
