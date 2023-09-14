import 'package:flutter/material.dart';
import 'package:flutter_application_auth/model/user.model.dart';
import 'package:flutter_application_auth/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  final UserService _userService = UserService();
  UserService get userService => _userService;

  Future<void> getCurrentUserCall(token) async {
    try {
      final res = await _userService.getCurrentUser(token);
      _user = res;
      notifyListeners();
    } catch (e) {
      throw Exception('Not found $e!');
    }
  }
}
