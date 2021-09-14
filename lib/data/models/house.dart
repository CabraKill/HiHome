class HouseModel {
  late String id;
  late String name;
  //TODO: Add document path

  HouseModel({required this.id, required this.name});

  HouseModel.fromJson(Map<String, dynamic> json)
      //TODO: Improve id search to use name path
      : id = json['id'],
        name = json['name']['stringValue'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
