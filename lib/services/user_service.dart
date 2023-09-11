import 'package:flutter/material.dart';
import 'package:flutter_application_auth/model/forgot_password.model.dart';
import 'package:flutter_application_auth/model/register.model.dart';
import 'package:flutter_application_auth/utils/handleCatchError.dart';
import 'package:http/http.dart' as http;

class UserService {
  // ignore: constant_identifier_names
  static const BASE_URL = 'http://192.168.0.193:3000';

  static Future<bool> register(
      BuildContext context, RegisterModelRequest requestModel) async {
    const url = '$BASE_URL/api/users';
    return await handleRequestAndCatchErrors(() async {
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: RegisterModelRequestToJson(requestModel));
      return response.statusCode == 200 ? true : false;
    });
  }

  static Future<bool> verify(email, verificationCode) async {
    final uri = Uri.parse(
        '$BASE_URL/api/users/verify/$email/$verificationCode'); // Construct the URI with path parameters
    return await handleRequestAndCatchErrors(() async {
      final reposne =
          await http.post(uri, headers: {"Content-Type": "application/json"});
      return reposne.statusCode == 201 ? true : false;
    });
  }

  static Future<bool> sendEmailForForgotPassword(
      ForgotPasswordModelRequest requestModel) async {
    final uri = Uri.parse('$BASE_URL/api/users/forgotpassword');
    return await handleRequestAndCatchErrors(() async {
      final response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: ForgotPasswordModelRequestToJson(requestModel));
      return response.statusCode == 200 ? true : false;
    });
  }

  static Future<bool> resetPassword(ResetPasswordModelRequeset requestModel,
      String id, String passwordResetCode) async {
    final uri =
        Uri.parse('$BASE_URL/api/users/resetpassword/$id/$passwordResetCode');
    return await handleRequestAndCatchErrors(() async {
      final response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: ResetPasswordModelRequesetToJson(requestModel));
      return response.statusCode == 200 ? true : false;
    });
  }
}
