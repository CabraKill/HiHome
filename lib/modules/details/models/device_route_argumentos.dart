import 'package:flutter/material.dart';
import 'package:hihome/domain/models/section.dart';

class DeviceRouteArguments {
  final SectionEntity section;
  final Size size;

  DeviceRouteArguments(this.section, this.size);
}
