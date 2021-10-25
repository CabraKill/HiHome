import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:mockito/mockito.dart';

class DataBaseMock extends Mock implements DataBase {
  // DataBaseMock(ConnectionClient connectionClient) : super(connectionClient);

  static final houseList = <SectionEntity>[
    SectionEntity(
      id: "23412",
      name: "Netuno Galáxia Club",
      path: '/house1',
    ),
    SectionEntity(
      id: "23412",
      name: "Marte Galáxia Club",
      path: '/house1',
    ),
  ];

  static final deviceList = <DeviceEntity>[
    DeviceEntity(
        id: "11",
        name: "mangueira varanda",
        state: 'on',
        point: DevicePointModel(x: 0.1, y: 0.2)),
    DeviceEntity(
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
  Future<List<SectionEntity>> getSectionList(String familyId) async {
    return houseList;
  }

  @override
  Future<List<DeviceEntity>> getDeviceList(String path) async {
    return deviceList;
  }

  @override
  Future<List<RoomModel>> getRoomList(String familyId, String homeId) async {
    return roomList;
  }
}
