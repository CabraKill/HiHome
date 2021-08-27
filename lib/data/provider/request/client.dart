import 'package:hihome/data/models/response.dart';

abstract class Client {
  Future<ResponseModel> getRequest(String url, Map<String, dynamic>? headers);
}
