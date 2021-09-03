class ConnectionException implements Exception {
  final String text;

  ConnectionException(this.text);

  @override
  String toString() => text;
}
