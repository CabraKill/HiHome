import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/modules/home/home_controller.dart';
import 'package:hihome/modules/home/widgets/details/bulb_widget.dart';

class _Rx {
  final onSwitch = false.obs;
  final deviceList = <DeviceModel>[].obs;
  final roomList = <RoomModel>[].obs;
  final position = Offset(0, 0).obs;
  final itens = <BulbWidget>[].obs;
}

class DetailsController extends GetxController {
  final _rx = new _Rx();
  final DataBase dataBase = Get.find();
  final HomeController homeController = Get.find();

  bool get onSwitch => _rx.onSwitch.value;
  set onSwitch(bool value) => _rx.onSwitch.value = value;

  Offset get position => _rx.position.value;
  set position(Offset offset) => _rx.position.value = offset;

  List<BulbWidget> get itens => _rx.itens;

  @override
  void onInit() {
    super.onInit();
    updateRoomList();
  }

  addWidgetToList(BulbWidget widget) {
    itens.add(widget);
  }

  void switchState() async {
    final connect = Connect();
    final response = await connect.switchSate();
    if (response.statusCode != 200) {
      Get.defaultDialog(
          title: "Erro",
          content: Text("Algo deu de errado.\n${response.body}"));
      return;
    }
    final Map<String, dynamic> bodyMap = jsonDecode(response.body);
    onSwitch = "on" == bodyMap['state'];
    print(onSwitch);
  }

  void updateDeviceList() async {
    _rx.deviceList.value =
        await dataBase.getDeviceList(homeController.house!.id);
    print(_rx.deviceList.map((device) => device.id).join(" - "));
  }

  void updateRoomList() async {
    _rx.roomList.value = await dataBase.getRoomList(homeController.house!.id);
    print(_rx.deviceList.map((device) => device.id).join(" - "));
  }
}

class Connect extends GetConnect {
  Future<Response> switchSate() => (get(
      'https://home-dbb7e.rj.r.appspot.com/homes/buHkimoPE1e5NMx7C4kX/devices/60:01:94:21:E7:FA/switch'));
}
