import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/data/provider/request/client_getx.dart';
import 'package:hihome/data/provider/request/connection_client.dart';
import 'package:hihome/routes/routes.dart';

class SplashController extends GetxController {
  static const loadingTime = 1000;
  @override
  void onReady() {
    super.onReady();
    initLoading();
  }

  void initLoading() async {
    final timeNow = DateTime.now();
    await GetStorage.init();
    Get.put(
      await DataBaseManager(
        ConnectionClient(
          client: ClientGetX(),
          baseUrl:
              "https://firestore.googleapis.com/v1/projects/home-dbb7e/databases/(default)",
        ),
      ).init(),
      permanent: true,
    );
    final time = timeLeft(timeNow);
    await Future.delayed(Duration(milliseconds: time));
    Get.offNamed(Routes.login);
  }

  int timeLeft(DateTime start) {
    final time = loadingTime - (start.difference(start).inMilliseconds).abs();
    return time < loadingTime ? 0 : time;
  }
}
