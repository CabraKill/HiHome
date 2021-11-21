import 'package:get/get.dart';
import 'package:hihome/modules/details/widgets/app_bar/app_bar_mode_type.dart';

class DetailsAppBarController {
  final currentModeRx = DetailsAppBarModeType.controll.obs;

  DetailsAppBarModeType get currentMode => currentModeRx.value;

  DetailsAppBarModeType get currentModeValue => currentModeRx.value;
  set currentModeValue(DetailsAppBarModeType value) =>
      currentModeRx.value = value;

  bool get isEditModeOn => currentModeValue == DetailsAppBarModeType.edit;
  bool get isControllModeOn => currentModeValue == DetailsAppBarModeType.controll;
  bool get isAnalysisModeOn => currentModeValue == DetailsAppBarModeType.analysis;

  void switchEditMode() {
    if (currentMode == DetailsAppBarModeType.controll) {
      currentModeValue = DetailsAppBarModeType.edit;
    } else {
      currentModeValue = DetailsAppBarModeType.controll;
    }
  }

  void switchAnalysisMode() {
    if (currentMode == DetailsAppBarModeType.analysis) {
      currentModeValue = DetailsAppBarModeType.controll;
    } else {
      currentModeValue = DetailsAppBarModeType.analysis;
    }
  }

  void chooseControllMode() {
    currentModeValue = DetailsAppBarModeType.controll;
  }
}
