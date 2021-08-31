import 'dart:async';
import 'dart:io';
import 'package:hihome/data/helper/connection_erro/connectionException_error.dart';
import 'package:hihome/data/helper/connection_erro/noConnection_error.dart';
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
    final requestHeaders = <String, String>{
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    return client.getRequest(baseUrl + route, requestHeaders);
  }

  Future<ResponseModel> post(String url, String body,
      {Map<String, dynamic>? headers,
      bool useBaseUrl = true,
      bool useDefaultHeaders = true}) {
    final requestHeaders = <String, String>{
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    final link = (useBaseUrl ? baseUrl : "") + url;
    try {
      return client.postRequest(link, body, requestHeaders);
    } on SocketException {
      throw NoConnectionException("Connection error");
    } on TimeoutException {
      rethrow;
    } catch (error) {
      throw ConnectionException(error.toString());
    }
  }
}
