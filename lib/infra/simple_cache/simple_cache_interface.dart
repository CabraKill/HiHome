abstract class SimpleCacheInterface {
  void updateValue(key, value);
  Future<T?> readValue<T>(key);
}
