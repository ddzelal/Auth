import 'package:flutter/material.dart';
import 'package:flutter_application_auth/components/app_button.dart';
import 'package:flutter_application_auth/components/app_text_field.dart';
import 'package:flutter_application_auth/components/app_toast.dart';
import 'package:flutter_application_auth/components/toolbar.dart';
import 'package:flutter_application_auth/config/app_routes.dart';
import 'package:flutter_application_auth/model/forgot_password.model.dart';
import 'package:flutter_application_auth/services/user_service.dart';
import 'package:flutter_application_auth/styles/app_text.dart';

class RequestForgotPasswordPage extends StatefulWidget {
  RequestForgotPasswordPage({super.key});

  @override
  State<RequestForgotPasswordPage> createState() =>
      _RequestForgotPasswordPageState();
}

bool loading = false;

class _RequestForgotPasswordPageState extends State<RequestForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  @override
  dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void sendEmailToResetPassword() async {
    setState(() {
      loading = true;
    });
    try {
      await Future.delayed(Duration(seconds: 1));
      final res = await UserService.sendEmailForForgotPassword(
          ForgotPasswordModelRequest(email: _emailController.text));
      if (res) {
        Navigator.pushNamed(context, AppRoutes.forgotPassword,
            arguments: {'email': _emailController.text});
        CustomToast.show(
            message: 'We send verification code , please check email');
      }
      if (!res) {
        CustomToast.show(message: 'Something wrong');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('sending code failed: $e'), // Display the error message
      ));
    }
    setState(() {
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(title: ''),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Forgot password?', style: AppText.header3),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please enter your emil address to reset your password.',
              style: AppText.paragraph3,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              leadingIcon: Icons.email,
              label: 'Enter your email address',
              controller: _emailController,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
                text: 'Send OTP',
                icon: Icons.arrow_right,
                loading: loading,
                onPressed: () => sendEmailToResetPassword()),
          ],
        ),
      ),
    );
  }
}
