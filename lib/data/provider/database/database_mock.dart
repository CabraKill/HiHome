import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:mockito/mockito.dart';

class DataBaseMock extends Mock implements DataBaseManager {
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
      bruteValue: 'on',
      point: DevicePointModel(x: 0.1, y: 0.2),
      type: DeviceType.generic,
      path: '/path',
    ),
    DeviceEntity(
      id: "22",
      name: "lamp quarto",
      bruteValue: 'off',
      type: DeviceType.generic,
      point: DevicePointModel(x: 0.8, y: 0.3),
      path: '/path',
    ),
  ];

  static final roomList = <RoomModel>[
    RoomModel(id: '010101', name: "room 3", deviceList: [])
  ];

  @override
  Future<DataBaseManager> init() async {
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
