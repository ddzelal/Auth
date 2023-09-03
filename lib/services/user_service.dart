import 'dart:convert';
import 'package:flutter_application_auth/components/app_toast.dart';
import 'package:flutter_application_auth/model/register.model.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static final BASE_URL = 'http://192.168.0.193:3000';
  static Future<dynamic> register(RegisterModelRequest requestModel) async {
    final url = '$BASE_URL/api/users';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: RegisterModelRequestToJson(requestModel));
      if (response.statusCode == 200) {
        json.decode(response.body);
      } else if (response.statusCode == 400) {
        var errors = jsonDecode(response.body);
        if (errors is List && errors.isNotEmpty) {
          String errorMessage = errors[0]['message'];
          CustomToast.show(message: errorMessage);
        }
      } else if (response.statusCode == 409) {
        CustomToast.show(message: 'Account already exists');
      }
    } catch (e) {
      print(e);
    }
  }
}
