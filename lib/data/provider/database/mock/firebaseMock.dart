import 'package:hihome/data/models/device.dart';
import 'package:hihome/data/models/house.dart';
import '../database_interface.dart';

class FirebaseMock implements DatabasePlatform {
  static final houseList = <HouseModel>[
    HouseModel(id: "23412", name: "Netuno Galáxia Club"),
    HouseModel(id: "23412", name: "Marte Galáxia Club"),
  ];

  static final deviceList = <DeviceModel>[
    DeviceModel(id: "11", name: "mangueira varanda", state: 'on'),
    DeviceModel(id: "22", name: "lamp quarto", state: 'off'),
  ];

  @override
  Future<DatabasePlatform> init() async {
    return this;
  }

  @override
  Future<List<HouseModel>> getHomeList() async {
    return houseList;
  }

  @override
  Future<List<DeviceModel>> getDeviceList(String homeId) async {
    return deviceList;
  }
}
