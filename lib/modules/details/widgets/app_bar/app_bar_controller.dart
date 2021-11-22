import 'package:get/get.dart';
import 'package:hihome/modules/details/widgets/app_bar/app_bar_mode_type.dart';
import 'package:hihome/modules/details/widgets/app_bar/section_mode_type.dart';

class DetailsAppBarController {
  final currentDeviceModeRx = DetailsAppBarModeType.controll.obs;
  final currentSectionModeRx = SectionMode.section.obs;

  DetailsAppBarModeType get currentDeviceMode => currentDeviceModeRx.value;
  set currentDeviceMode(DetailsAppBarModeType value) =>
      currentDeviceModeRx.value = value;

  SectionMode get currentSectionMode => currentSectionModeRx.value;
  set currentSectionMode(SectionMode value) =>
      currentSectionModeRx.value = value;

  bool get isEditModeOn => currentDeviceMode == DetailsAppBarModeType.edit;
  bool get isControllModeOn =>
      currentDeviceMode == DetailsAppBarModeType.controll;
  bool get isAnalysisModeOn =>
      currentDeviceMode == DetailsAppBarModeType.analysis;
  bool get isSectionModeOn => currentSectionMode == SectionMode.section;
  bool get isDeviceModeOn => currentSectionMode == SectionMode.device;

  void switchEditMode() {
    if (currentDeviceMode == DetailsAppBarModeType.controll) {
      currentDeviceMode = DetailsAppBarModeType.edit;
    } else {
      currentDeviceMode = DetailsAppBarModeType.controll;
    }
  }

  void switchAnalysisMode() {
    if (currentDeviceMode == DetailsAppBarModeType.analysis) {
      currentDeviceMode = DetailsAppBarModeType.controll;
    } else {
      currentDeviceMode = DetailsAppBarModeType.analysis;
    }
  }

  void chooseControllMode() {
    currentDeviceMode = DetailsAppBarModeType.controll;
  }

  void switchSectionMode() {
    if (currentSectionMode == SectionMode.section) {
      currentSectionMode = SectionMode.device;
    } else {
      currentSectionMode = SectionMode.section;
    }
  }
}
