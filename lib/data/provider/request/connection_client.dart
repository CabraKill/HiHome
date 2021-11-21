import 'dart:async';
import 'dart:io';
import 'package:hihome/data/helper/connection_erro/auth_error.dart';
import 'package:hihome/data/helper/connection_erro/connection_exception_error.dart';
import 'package:hihome/data/helper/connection_erro/no_connection_error.dart';
import 'package:hihome/data/models/response.dart';
import 'package:hihome/data/provider/request/client.dart';

class ConnectionClient {
  final String baseUrl;
  final Client client;
  late Map<String, dynamic> defaultHeaders;

  ConnectionClient({
    required this.client,
    required this.baseUrl,
    Map<String, dynamic>? defaultHeaders,
  }) {
    this.defaultHeaders = defaultHeaders ?? {};
  }

  Future<ResponseModel> get(
    String route, {
    Map<String, dynamic>? headers,
    bool useDefaultHeaders = true,
  }) async {
    final requestHeaders = <String, String>{
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    final response = await executeRequest(() => client.getRequest(baseUrl + route, requestHeaders));
    return response;
  }

  Future<ResponseModel> post(
    String url,
    String body, {
    Map<String, dynamic>? headers,
    bool useBaseUrl = true,
    bool useDefaultHeaders = true,
  }) async {
    final requestHeaders = <String, String>{
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    final link = (useBaseUrl ? baseUrl : "") + url;
    final request = await executeRequest(
        () => client.postRequest(link, body, requestHeaders));
    return request;
  }

  Future<ResponseModel> patch(
    String url,
    String body, {
    Map<String, dynamic>? headers,
    bool useBaseUrl = true,
    bool useDefaultHeaders = true,
  }) async {
    final requestHeaders = <String, String>{
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    final link = (useBaseUrl ? baseUrl : "") + url;
    final response = await executeRequest(
      () => client.patchRequest(link, body, requestHeaders),
    );
    return response;
  }

  Future<ResponseModel> delete(
    String url, {
    Map<String, dynamic>? headers,
    bool useBaseUrl = true,
    bool useDefaultHeaders = true,
  }) {
    final requestHeaders = <String, String>{
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    final link = (useBaseUrl ? baseUrl : "") + url;
    final response =
        executeRequest(() => client.deleteRequest(link, requestHeaders));
    return response;
  }

  Future<ResponseModel> executeRequest(_RequestFunction requestFunction) async {
    try {
      final response = await requestFunction();
      if (response.statusCode == 403 || response.statusCode == 401) {
        throw AuthException(response.body);
      }
      if (response.statusCode != 200) {
        throw ConnectionException(response.body);
      }
      return response;
    } on ConnectionException {
      rethrow;
    } on SocketException {
      throw NoConnectionException("No connection error");
    } on TimeoutException {
      rethrow;
    } on AuthException {
      rethrow;
    } catch (error) {
      throw ConnectionException(error.toString());
    }
  }
}

typedef _RequestFunction = Future<ResponseModel> Function();
