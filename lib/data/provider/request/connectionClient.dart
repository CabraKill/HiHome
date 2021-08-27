import 'package:hihome/data/models/response.dart';

class ConnectionClient {
  final String baseUrl;
  final client;

  ConnectionClient(this.client, this.baseUrl);

  Future<Response> get() {}
}
