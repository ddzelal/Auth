// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_auth/components/app_button.dart';
import 'package:flutter_application_auth/components/app_text_field.dart';
import 'package:flutter_application_auth/components/app_toast.dart';
import 'package:flutter_application_auth/config/app_routes.dart';
import 'package:flutter_application_auth/config/app_strings.dart';
import 'package:flutter_application_auth/model/login_session.model.dart';
import 'package:flutter_application_auth/provider/auth.provider.dart';
import 'package:flutter_application_auth/services/auth_service.dart';
import 'package:flutter_application_auth/styles/app_colors.dart';
import 'package:flutter_application_auth/styles/app_text.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isChecked = false;
  bool loading = false;
  void login() async {
    setState(() {
      loading = true;
    });

    try {
      final res = await AuthService().login(LoginRequestModel(
          email: _emailController.text, password: _passwordController.text));
      if (res == 'Invalid email or password') {
        CustomToast.show(message: 'Invalid email or password');
      } else if (res is LoginResponseModel) {
        final accessToken = res.accessToken;
        print('AccessToken: $accessToken');
      } else {
        CustomToast.show(
            message: 'Please verify your account , check your email!');
        Navigator.pushNamed(context, AppRoutes.verifyPage,
            arguments: {'email': _emailController.text});
      }
    } catch (e) {
      // Uhvaćena je greška prilikom poziva servisa.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login failed: $e'), // Prikazivanje poruke o grešci
      ));
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width),
          decoration: BoxDecoration(color: AppColors.backgroundApp),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: const Color.fromARGB(255, 143, 126, 125),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    AppStrings.titleLoginText,
                    style: AppText.paragraph3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Text(AppStrings.login,
                      style: AppText.header3, textAlign: TextAlign.end),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailController,
                    onChange: (value) => print(value),
                    label: AppStrings.email,
                    leadingIcon: Icons.email,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordController,
                    onChange: (value) => print(value),
                    label: AppStrings.password,
                    leadingIcon: Icons.lock,
                    trailingIcon: Icons.visibility,
                    isPassword: true,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _isChecked,
                          onChanged: (value) => setState(() {
                            _isChecked = !_isChecked;
                          }),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(AppStrings.rememberMe, style: AppText.paragraph3),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.requestForgotPassword),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(AppStrings.forgotPassword,
                                  style: AppText.paragraph3)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Consumer<AuthProvider>(builder: (context, auth, child) {
                    return CustomButton(
                      loading: loading,
                      text: AppStrings.login,
                      onPressed: () {
                        auth.loginCall(
                            context,
                            _emailController,
                            LoginRequestModel(
                                email: _emailController.text,
                                password: _passwordController.text));
                      },
                    );
                  }
                      // child: CustomButton(
                      //   loading: loading,
                      //   text: AppStrings.login,
                      //   icon: Icons.login,
                      //   onPressed: () => {},
                      // ),
                      ),
                  SizedBox(height: 20),
                  Center(
                      child: Text(AppStrings.dontHaveAccount,
                          style: AppText.paragraph3)),
                  SizedBox(height: 20),
                  CustomButton(
                    text: AppStrings.register,
                    icon: Icons.app_registration,
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
