import 'dart:convert';

import 'package:flutter_application_auth/config/app_url.dart';
import 'package:flutter_application_auth/model/login_session.model.dart';
import 'package:flutter_application_auth/utils/handleCatchError.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const BASE_URL = AppUrl.localUrl;

  Future<dynamic> login(LoginRequestModel loginRequest) async {
    return await handleRequestAndCatchErrors(() async {
      const url = '$BASE_URL/api/sessions';
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: LoginRequestModelToJson(loginRequest));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LoginResponseModel.fromJson(data);
      } else if (response.statusCode == 400) {
        return 'Invalid email or password';
      } else {
        return 'User not verified';
      }
    });
  }
}
