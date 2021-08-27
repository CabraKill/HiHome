import 'package:hihome/data/models/response.dart';
import 'package:hihome/data/provider/request/client.dart';

class ConnectionClient {
  final String baseUrl;
  final Client client;
  late Map<String, dynamic> defaultHeaders;

  ConnectionClient(
      {required this.client,
      required this.baseUrl,
      Map<String, dynamic>? defaultHeaders}) {
    this.defaultHeaders = defaultHeaders ?? {};
  }

  Future<ResponseModel> get(String route,
      {Map<String, dynamic>? headers, bool useDefaultHeaders = true}) {
    final requestHeaders = {
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    return client.getRequest(baseUrl + route, requestHeaders);
  }
}
