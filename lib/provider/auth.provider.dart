import 'package:flutter/material.dart';
import 'package:flutter_application_auth/components/app_toast.dart';
import 'package:flutter_application_auth/config/app_routes.dart';
import 'package:flutter_application_auth/model/login_session.model.dart';
import 'package:flutter_application_auth/pages/home_page.dart';
import 'package:flutter_application_auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;

  final AuthService _authService = AuthService();

  AuthService get authService => _authService;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  void setAccessToken(String token) {
    _accessToken = token;
    _saveAccessToken(token);
    notifyListeners();
  }

  void setRefreshToken(String token) {
    _refreshToken = token;
    _saveRefreshToken(token);
    notifyListeners();
  }

  Future<void> _saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<void> _saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refresh_token', token);
  }

  Future<void> loginCall(
      BuildContext context,
      TextEditingController emailController,
      LoginRequestModel loginRequest) async {
    try {
      final response = await _authService.login(loginRequest);
      if (response is LoginResponseModel) {
        setAccessToken(response.accessToken);
        setRefreshToken(response.refreshToken);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
      } else if (response == 'Invalid email or password') {
        CustomToast.show(message: 'Invalid email or password');
      } else {
        CustomToast.show(
            message: 'Please verify your account , check your email!');
        Navigator.pushNamed(context, AppRoutes.verifyPage,
            arguments: {'email': emailController.text});
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout(BuildContext context) async {
    _accessToken = null;
    _refreshToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (Route<dynamic> route) => false,
    );
  }
}
