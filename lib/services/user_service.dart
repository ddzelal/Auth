import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_auth/components/app_toast.dart';
import 'package:flutter_application_auth/exceptions/app_custom_exception.dart';
import 'package:flutter_application_auth/model/forgot_password.model.dart';
import 'package:flutter_application_auth/model/register.model.dart';
import 'package:flutter_application_auth/utils/handleCatchError.dart';
import 'package:http/http.dart' as http;

class UserService {
  // ignore: constant_identifier_names
  static const BASE_URL = 'http://192.168.0.193:3000';

  static Future<dynamic> register(
      BuildContext context, RegisterModelRequest requestModel) async {
    const url = '$BASE_URL/api/users';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: RegisterModelRequestToJson(requestModel));
      if (response.statusCode == 200) {
        CustomToast.show(
            message: 'User successfully created, please verify your account');
        return true;
      } else if (response.statusCode == 409) {
        return CustomToast.show(message: 'Account already exists');
      }
    } on SocketException catch (_) {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException catch (_) {
      throw InvalidFormatException('Invalid Data Format');
    } catch (_) {
      throw UnknownException('Unknow');
    }
  }

  static Future<dynamic> verify(email, verificationCode) async {
    final uri = Uri.parse(
        '$BASE_URL/api/users/verify/$email/$verificationCode'); // Construct the URI with path parameters
    try {
      final reposne =
          await http.post(uri, headers: {"Content-Type": "application/json"});
      if (reposne.statusCode == 201) {
        CustomToast.show(message: 'User successfully verify');
        return true;
      }
      if (reposne.statusCode == 404) {
        return CustomToast.show(
            message: 'Could not verify user,please chech your email');
      }
    } on SocketException catch (_) {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException catch (_) {
      throw InvalidFormatException('Invalid Data Format');
    } catch (_) {
      throw UnknownException('Unknow');
    }
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
