import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DeviceZoomType {
  normal,
  medium,
  large,
  xlarge,
}

extension DeviceIconFactor on DeviceZoomType {
  double get factor {
    switch (this) {
      case DeviceZoomType.normal:
        return 1.0;
      case DeviceZoomType.medium:
        return 1.5;
      case DeviceZoomType.large:
        return 2.0;
      case DeviceZoomType.xlarge:
        return 3.0;
    }
  }

  DeviceZoomType get next {
    switch (this) {
      case DeviceZoomType.normal:
        return DeviceZoomType.medium;
      case DeviceZoomType.medium:
        return DeviceZoomType.large;
      case DeviceZoomType.large:
        return DeviceZoomType.xlarge;
      case DeviceZoomType.xlarge:
        return DeviceZoomType.normal;
    }
  }

  IconData get iconData {
    switch (this) {
      case DeviceZoomType.normal:
        return Icons.looks_one;
      case DeviceZoomType.medium:
        return Icons.looks_two;
      case DeviceZoomType.large:
        return Icons.looks_3;
      case DeviceZoomType.xlarge:
        return Icons.looks_4;
    }
  }
}
