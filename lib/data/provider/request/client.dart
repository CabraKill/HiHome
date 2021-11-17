import 'package:hihome/data/models/response.dart';

abstract class Client {
  Future<ResponseModel> getRequest(
    String url,
    Map<String, String>? headers,
  );
  Future<ResponseModel> postRequest(
    String url,
    String body,
    Map<String, String>? headers,
  );
  Future<ResponseModel> patchRequest(
    String link,
    String body,
    Map<String, String> requestHeaders,
  );
}
