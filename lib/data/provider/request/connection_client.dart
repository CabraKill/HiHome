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

  ConnectionClient(
      {required this.client,
      required this.baseUrl,
      Map<String, dynamic>? defaultHeaders}) {
    this.defaultHeaders = defaultHeaders ?? {};
  }

  Future<ResponseModel> get(String route,
      {Map<String, dynamic>? headers, bool useDefaultHeaders = true}) async {
    final requestHeaders = <String, String>{
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    ResponseModel response;
    try {
      response = await client.getRequest(baseUrl + route, requestHeaders);
    } on SocketException {
      throw NoConnectionException("No connection error");
    } on TimeoutException {
      rethrow;
    } catch (error) {
      throw ConnectionException(error.toString());
    }
    if (response.statusCode == 403) throw AuthException(response.body);
    return response;
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

  Future<ResponseModel> patch(
    String url,
    String body, {
    Map<String, dynamic>? headers,
    bool useBaseUrl = true,
    bool useDefaultHeaders = true,
  }) {
    final requestHeaders = <String, String>{
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    final link = (useBaseUrl ? baseUrl : "") + url;
    try {
      return client.patchRequest(link, body, requestHeaders);
    } on SocketException {
      throw NoConnectionException("Connection error");
    } on TimeoutException {
      rethrow;
    } catch (error) {
      throw ConnectionException(error.toString());
    }
  }

  Future<ResponseModel> delete(String url,
      {Map<String, dynamic>? headers,
      bool useBaseUrl = true,
      bool useDefaultHeaders = true}) {
    final requestHeaders = <String, String>{
      if (useDefaultHeaders) ...defaultHeaders,
      ...headers ?? {}
    };
    final link = (useBaseUrl ? baseUrl : "") + url;
    try {
      return client.deleteRequest(link, requestHeaders);
    } on SocketException {
      throw NoConnectionException("Connection error");
    } on TimeoutException {
      rethrow;
    } catch (error) {
      throw ConnectionException(error.toString());
    }
  }
}
