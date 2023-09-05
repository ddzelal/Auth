import 'package:flutter/material.dart';
import 'package:flutter_application_auth/pages/login_page.dart';
import 'package:flutter_application_auth/pages/register_page.dart';
import 'package:flutter_application_auth/pages/verify_page.dart';

class AppRoutes {
  static final pages = {
    // login: (context) => ChangeNotifierProvider(
    //       create: (context) => LoginProvider(),
    //       child: LoginPage(),
    // ),
    // home: (context) => Container(
    //       child: Center(
    //           child: Text(
    //         'home',
    //         style: AppText.header2,
    //       )),
    //     ),
    login: (context) => LoginPage(),
    register: (context) => RegisterPage(),
    home: (context) => Container(
          child: Text('Wellcome to home page'),
        ),
    initialPage: (context) => Text('Init Page'),
    verifyPage: (context) => VerifyPage()
    // editProfile: (context) => EditProfilePage(),
    // nearby: (context) => NearbyPage(),
    // user: (context) => UserPage(),
  };

  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const main = '/main';
  static const initialPage = '/';
  static const verifyPage = '/verify';
}
