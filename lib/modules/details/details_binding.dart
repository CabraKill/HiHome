import 'package:get/get.dart';
import 'package:hihome/data/repositories/database_repository_impl.dart';
import 'package:hihome/data/usecases/add_device_usecase_impl.dart';
import 'package:hihome/data/usecases/update_device_value_usecase_impl.dart';
import 'package:hihome/data/usecases/update_onoff_value_usecase_impl.dart';

import 'details_controller.dart';

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(
      () => DetailsController(
        Get.find<DatabaseRepositoryImpl>(),
        addDeviceUseCaseImpl: AddDeviceUseCaseImpl(
          Get.find<DatabaseRepositoryImpl>(),
        ),
      ),
    );
    Get.lazyPut(
      () => UpdateDeviceValueUseCaseImpl(
        UpdateOnOffValueUseCaseImpl(Get.find<DatabaseRepositoryImpl>()),
      ),
    );
  }
}
