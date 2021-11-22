import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/modules/details/widgets/app_bar/app_bar_widget.dart';
import 'package:hihome/modules/details/widgets/details_view.dart';
import 'package:hihome/modules/home/widgets/homeChooser/section_chooser_widget.dart';
import 'details_controller.dart';

class DetailsPage extends GetView<DetailsController> with DetailsAppBarWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: appBar(controller),
        body: Center(
          child: Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                child: child,
                opacity: animation,
              ),
              child: controller.isSectionModeOn
                  ? controller.subSectionList.builder(
                      onSuccess: (sections) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.2,
                          horizontal: Get.width * 0.2,
                        ),
                        child: SectionChooser(
                          sections: sections,
                          ontap: controller.goToSection,
                        ),
                      ),
                    )
                  : DetailsView(
                      controller: controller,
                      offSetHeight: controller.offSetHeight,
                    ),
            ),
          ),
        ),
      );
    });
  }

  void addDevice(DeviceType type, DevicePointModel point) {
    controller.addDeviceToList(createDeviceFromType(type, point));
    debugPrint(controller.devices.toString());
  }

  DeviceEntity createDeviceFromType(DeviceType type, DevicePointModel point) {
    return DeviceEntity(
      id: '0',
      name: '',
      bruteValue: '',
      point: point,
      type: type,
      path: '',
    );
  }
}
