import 'package:get/get_connect.dart';
import 'package:hihome/data/models/response.dart';
import 'package:hihome/data/provider/request/client.dart';

class ClientGetX extends GetConnect implements Client {
  @override
  Future<ResponseModel> getRequest(
      String url, Map<String, dynamic>? headers) async {
    final response = await get(url);
    final responseModel =
        ResponseModel(response.statusCode!, response.bodyString ?? "");
    return responseModel;
  }
}
