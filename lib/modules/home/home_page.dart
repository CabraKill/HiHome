import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/modules/home/widgets/homeChooser/home_chooser_widget.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.offSetHeight = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Center(
          child: Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                child: child,
                opacity: animation,
              ),
              child: controller.family.builder(
                onSuccess: (unit) {
                  //TODO: refactor this flow
                  // if (controller.isHomeChoosed) {
                  //   return DetailsPage(
                  //     offSetHeight: appBar.preferredSize.height,
                  //   );
                  // }
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.2,
                      horizontal: Get.width * 0.2,
                    ),
                    child: SectionChooser(
                      sections: unit.value.sectionList ?? [],
                      ontap: controller.goToDetails,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar get appBar => AppBar(
        title: const Text('HomePage'),
        actions: [
          IconButton(
            onPressed: controller.updateFamily,
            icon: const Icon(Icons.update),
          )
        ],
      );
}
