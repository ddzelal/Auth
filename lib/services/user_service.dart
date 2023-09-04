import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_auth/components/app_toast.dart';
import 'package:flutter_application_auth/exceptions/app_custom_exception.dart';
import 'package:flutter_application_auth/model/register.model.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static const BASE_URL = 'http://192.168.0.193:3000';
  static Future<dynamic> register(RegisterModelRequest requestModel) async {
    final url = '$BASE_URL/api/users';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: RegisterModelRequestToJson(requestModel));
      if (response.statusCode == 200) {
        CustomToast.show(
            message: 'User successfully created, please verify your account');
        return json.decode(response.body);
      } else if (response.statusCode == 409) {
        return CustomToast.show(message: 'Account already exists');
      }
      print(jsonDecode(response.body));
    } on SocketException catch (e) {
      print(e);
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException catch (e) {
      print(e);
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      print(e);
      throw UnknownException('Unknow');
    }
  }
}
