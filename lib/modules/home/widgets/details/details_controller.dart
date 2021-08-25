import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/modules/home/home_controller.dart';

class _Rx {
  final onSwitch = false.obs;
  final deviceList = <DeviceModel>[].obs;
}

class DetailsController extends GetxController {
  final _rx = new _Rx();
  final DataBase dataBase = Get.find();
  final HomeController homeController = Get.find();

  bool get onSwitch => _rx.onSwitch.value;
  set onSwitch(bool value) => _rx.onSwitch.value = value;

  @override
  void onInit() {
    super.onInit();
    updateDeviceList();
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
}

class Connect extends GetConnect {
  Future<Response> switchSate() => (get(
      'https://home-dbb7e.rj.r.appspot.com/homes/buHkimoPE1e5NMx7C4kX/devices/60:01:94:21:E7:FA/switch'));
}
