import 'package:flutter/material.dart';
import 'package:flutter_application_auth/pages/forgot_password.dart';
import 'package:flutter_application_auth/pages/home_page.dart';
import 'package:flutter_application_auth/pages/login_page.dart';
import 'package:flutter_application_auth/pages/register_page.dart';
import 'package:flutter_application_auth/pages/request_forgot_password_page.dart';
import 'package:flutter_application_auth/pages/verify_page.dart';

class AppRoutes {
  static final pages = {
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    register: (context) => RegisterPage(),
    initialPage: (context) => Text('Init Page'),
    verifyPage: (context) => VerifyPage(),
    requestForgotPassword: (context) => RequestForgotPasswordPage(),
    forgotPassword: (context) => ForgotPasswordPage()
  };

  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const main = '/main';
  static const initialPage = '/';
  static const verifyPage = '/verify';
  static const requestForgotPassword = '/requestforgotpassword';
  static const forgotPassword = '/forgotpassword';
}
