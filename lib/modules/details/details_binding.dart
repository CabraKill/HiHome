import 'package:get/get.dart';
import 'package:hihome/data/repositories/database_repository_impl.dart';
import 'package:hihome/data/usecases/add_device_usecase_impl.dart';
import 'package:hihome/data/usecases/edit_device_usecase_impl.dart';
import 'package:hihome/data/usecases/get_device_log_list_usecase.dart';
import 'package:hihome/data/usecases/remove_device_usecase_impl.dart';

import 'details_controller.dart';

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(
      () => DetailsController(
        Get.find<DatabaseRepositoryImpl>(),
        addDeviceUseCaseImpl: Get.find<AddDeviceUseCaseImpl>(),
        removeDeviceUseCaseImpl: Get.find<RemoveDeviceUseCaseImpl>(),
        editDeviceUseCaseImpl: Get.find<EditDeviceUseCaseImpl>(),
        getDeviceLogListUseCase: Get.find<GetDeviceLogListUseCaseImpl>(),
      ),
    );
    
  }
}
