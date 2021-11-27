import 'dart:io';

import 'package:flutter/foundation.dart';

bool get isWeb {
  try {
    return kIsWeb;
  } catch (e) {
    return false;
  }
}

bool get isWindows {
  try {
    return Platform.isWindows;
  } catch (e) {
    return false;
  }
}
