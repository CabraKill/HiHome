import 'package:get_storage/get_storage.dart';
import 'package:hihome/infra/simple_cache/simple_cache_interface.dart';

class CacheGet implements SimpleCacheInterface {
  @override
  Future<T?> readValue<T>(key) async {
    final value = box.read(key);
    return value;
  }

  @override
  void updateValue(key, value) {
    box.write(key, value);
  }

  GetStorage get box => GetStorage();
}
