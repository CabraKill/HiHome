import 'package:get/get.dart';
import 'package:hihome/infra/simple_cache/simple_cache_interface.dart';

class SimpleCache implements SimpleCacheInterface {
  final SimpleCacheInterface cache;

  SimpleCache(this.cache);

  static SimpleCache get instance => Get.find();

  @override
  Future<T?> readValue<T>(key) {
    return cache.readValue(key);
  }

  @override
  void updateValue(key, value) {
    return cache.updateValue(key, value);
  }
}
