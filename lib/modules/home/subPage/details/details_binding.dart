import 'package:get/get.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/data/repositories/database_repository_impl.dart';
import 'package:hihome/modules/home/subPage/details/details_controller.dart';

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(
        () => DetailsController(DatabaseRepositoryImpl(Get.find<DataBase>())));
  }
}
