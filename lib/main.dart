import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: Routes.SPLASH,
    getPages: AppPages.pages,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.dark,
  ));
}
