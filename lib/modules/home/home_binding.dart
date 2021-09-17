import 'package:get/get.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/data/repositories/database_repository_impl.dart';
import 'package:hihome/data/repositories/user_details_repository_impl.dart';
import 'package:hihome/data/usecases/get_unit_usecase.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
        UserDetailsRepositoryImpl(),
        GetUnitUseCaseImpl(DatabaseRepositoryImpl(Get.find<DataBase>()))));
  }
}
