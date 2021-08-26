import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/device/devicePoint.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/provider/database/database.dart';

class DataBaseMock extends DataBase {
  static final houseList = <HouseModel>[
    HouseModel(id: "23412", name: "Netuno Galáxia Club"),
    HouseModel(id: "23412", name: "Marte Galáxia Club"),
  ];

  static final deviceList = <DeviceModel>[
    DeviceModel(
        id: "11",
        name: "mangueira varanda",
        state: 'on',
        point: DevicePointModel(x: 0.1, y: 0.2)),
    DeviceModel(
        id: "22",
        name: "lamp quarto",
        state: 'off',
        point: DevicePointModel(x: 0.8, y: 0.3)),
  ];

  static final roomList = <RoomModel>[
    RoomModel(id: '010101', name: "room 3", deviceList: [])
  ];

  @override
  Future<DataBase> init() async {
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

  @override
  Future<List<RoomModel>> getRoomList() async {
    return roomList;
  }
}
