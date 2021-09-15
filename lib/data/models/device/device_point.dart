class DevicePointModel {
  double x;
  double y;

  DevicePointModel({required this.x, required this.y});

  DevicePointModel.fromJson(Map<String, dynamic> json)
      : x = json['x'],
        y = json['y'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = x;
    data['y'] = y;
    return data;
  }
}
