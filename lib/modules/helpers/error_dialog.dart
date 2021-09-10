import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin ErrorDialog {
  Future<T?> showErrorDialog<T>(Widget? content) {
    return Get.defaultDialog<T>(title: "Error", content: content);
  }
}
