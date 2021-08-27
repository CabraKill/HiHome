import 'package:get/get_connect.dart';
import 'package:hihome/data/models/response.dart';
import 'package:hihome/data/provider/request/client.dart';

class ClientGetX extends GetConnect implements Client {
  @override
  Future<ResponseModel> getRequest(
      String url, Map<String, String>? headers) async {
    final response = await get(url, headers: headers);
    final responseModel =
        ResponseModel(response.statusCode!, response.bodyString ?? "");
    return responseModel;
  }

  @override
  Future<ResponseModel> postRequest(
      String url, String body, Map<String, String>? headers) async {
    final response = await post(url, body, headers: headers);
    final responseModel =
        ResponseModel(response.statusCode!, response.bodyString ?? "");
    return responseModel;
  }
}
