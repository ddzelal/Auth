import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_auth/config/app_url.dart';
import 'package:flutter_application_auth/model/forgot_password.model.dart';
import 'package:flutter_application_auth/model/register.model.dart';
import 'package:flutter_application_auth/model/user.model.dart';
import 'package:flutter_application_auth/utils/handleCatchError.dart';
import 'package:http/http.dart' as http;

class UserService {
  // ignore: constant_identifier_names
  static const BASE_URL = AppUrl.localUrl;

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

  Future<User> getCurrentUser(token) async {
    const url = '$BASE_URL/api/users/me';
    return await handleRequestAndCatchErrors(() async {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return User.fromJson(jsonDecode(response.body));
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
