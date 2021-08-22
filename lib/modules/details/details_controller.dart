import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _Rx {
  final onSwitch = false.obs;
}

class DetailsController extends GetxController {
  final _rx = new _Rx();

  bool get onSwitch => _rx.onSwitch.value;
  set onSwitch(bool value) => _rx.onSwitch.value = value;

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
}

class Connect extends GetConnect {
  Future<Response> switchSate() => (get(
      'https://home-dbb7e.rj.r.appspot.com/homes/buHkimoPE1e5NMx7C4kX/devices/60:01:94:21:E7:FA/switch'));
}
