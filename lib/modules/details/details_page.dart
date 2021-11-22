import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/repositories/database_repository_impl.dart';
import 'package:hihome/data/usecases/add_device_usecase_impl.dart';
import 'package:hihome/data/usecases/edit_device_usecase_impl.dart';
import 'package:hihome/data/usecases/get_device_log_list_usecase.dart';
import 'package:hihome/data/usecases/remove_device_usecase_impl.dart';
import 'package:hihome/modules/details/widgets/app_bar/app_bar_widget.dart';
import 'package:hihome/modules/details/widgets/details_view.dart';
import 'package:hihome/modules/home/widgets/homeChooser/section_chooser_widget.dart';
import 'details_controller.dart';

class DetailsPage extends StatelessWidget with DetailsAppBarWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(
      tag: Get.currentRoute,
      init: DetailsController(
        Get.find<DatabaseRepositoryImpl>(),
        addDeviceUseCaseImpl: Get.find<AddDeviceUseCaseImpl>(),
        removeDeviceUseCaseImpl: Get.find<RemoveDeviceUseCaseImpl>(),
        editDeviceUseCaseImpl: Get.find<EditDeviceUseCaseImpl>(),
        getDeviceLogListUseCase: Get.find<GetDeviceLogListUseCaseImpl>(),
      ),
      builder: (controller) {
        return Obx(() {
          return Scaffold(
            appBar: appBar(controller),
            body: Center(
              child: AnimatedSwitcher(
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
          );
        });
      },
    );
  }
}
