class DeviceModel {
  final String id;
  final String state;
  final String name;

  DeviceModel({required this.id, required this.name, required this.state});

  DeviceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        state = json['state'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['state'] = state;
    data['name'] = name;
    return data;
  }
}
