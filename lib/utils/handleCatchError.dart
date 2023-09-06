import 'dart:io';
import 'package:flutter_application_auth/exceptions/app_custom_exception.dart';

Future<dynamic> handleRequestAndCatchErrors(
    Future<dynamic> Function() request) async {
  try {
    final response = await request();
    return (response);
  } on SocketException catch (_) {
    throw NoInternetException('No Internet');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException catch (_) {
    throw InvalidFormatException('Invalid Data Format');
  } catch (_) {
    throw UnknownException('Unknown');
  }
}
