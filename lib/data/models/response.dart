import 'dart:convert';

class ResponseModel {
  final int statusCode;
  final String body;

  ResponseModel(this.statusCode, this.body);

  Map<String, dynamic> get bodyJson => jsonDecode(body);
}
