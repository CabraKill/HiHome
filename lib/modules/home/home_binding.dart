import 'package:get/get.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/data/repositories/database_repository_impl.dart';
import 'package:hihome/data/repositories/user_details_repository_impl.dart';
import 'package:hihome/data/usecases/add_device_usecase_impl.dart';
import 'package:hihome/data/usecases/edit_device_usecase_impl.dart';
import 'package:hihome/data/usecases/get_device_log_list_usecase.dart';
import 'package:hihome/data/usecases/get_unit_usecase.dart';
import 'package:hihome/data/usecases/remove_device_usecase_impl.dart';
import 'package:hihome/data/usecases/update_device_value_usecase_impl.dart';
import 'package:hihome/data/usecases/update_onoff_value_usecase_impl.dart';
import 'package:hihome/infra/simple_cache/cache_get.dart';
import 'package:hihome/infra/simple_cache/simple_cache.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatabaseRepositoryImpl>(
      () => DatabaseRepositoryImpl(Get.find<DataBaseManager>()),
      fenix: true,
    );
    Get.lazyPut<AddDeviceUseCaseImpl>(
      () => AddDeviceUseCaseImpl(
        Get.find<DatabaseRepositoryImpl>(),
      ),
      fenix: true,
    );
    Get.lazyPut<RemoveDeviceUseCaseImpl>(
      () => RemoveDeviceUseCaseImpl(
        Get.find<DatabaseRepositoryImpl>(),
      ),
      fenix: true,
    );
    Get.lazyPut<EditDeviceUseCaseImpl>(
      () => EditDeviceUseCaseImpl(
        Get.find<DatabaseRepositoryImpl>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GetDeviceLogListUseCaseImpl>(
      () => GetDeviceLogListUseCaseImpl(
        Get.find<DatabaseRepositoryImpl>(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => UpdateDeviceValueUseCaseImpl(
        UpdateOnOffValueUseCaseImpl(Get.find<DatabaseRepositoryImpl>()),
      ),
      fenix: true,
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        UserDetailsRepositoryImpl(),
        GetUnitUseCaseImpl(Get.find<DatabaseRepositoryImpl>()),
      ),
    );
    Get.put(SimpleCache(CacheGet()), permanent: true);
  }
}
