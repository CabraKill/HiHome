import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showConfirmRemoveDevice() async {
  final result = await Get.defaultDialog<bool?>(
    title: "Remove Device",
    content: const Text("Are you sure you want to remove this device?"),
    actions: <Widget>[
      TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Get.back(result: false);
        },
      ),
      TextButton(
        child: const Text("Remove"),
        onPressed: () {
          Get.back(result: true);
        },
      ),
    ],
  );
  return result ?? false;
}
