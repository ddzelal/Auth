import 'package:flutter/material.dart';
import 'package:flutter_application_auth/components/app_button.dart';
import 'package:flutter_application_auth/components/app_text_field.dart';
import 'package:flutter_application_auth/components/app_toast.dart';
import 'package:flutter_application_auth/components/toolbar.dart';
import 'package:flutter_application_auth/config/app_routes.dart';
import 'package:flutter_application_auth/model/forgot_password.model.dart';
import 'package:flutter_application_auth/services/user_service.dart';
import 'package:flutter_application_auth/styles/app_text.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

bool loading = false;

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _verificationCode = TextEditingController();
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _repetNewPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  dispose() {
    _verificationCode.dispose();
    _userId.dispose();
    _newPassword.dispose();
    _repetNewPassword.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? email = args['email'];

    void callSendResetPassword() async {
      setState(() {
        loading = true;
      });
      try {
        final res = await UserService.resetPassword(
            ResetPasswordModelRequeset(
                email: email as String,
                password: _newPassword.text,
                passwordConfirmation: _repetNewPassword.text),
            _userId.text,
            _verificationCode.text);
        setState(() {
          loading = false;
        });
        CustomToast.show(message: 'Successfully update passowrd');
        if (res) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
        print(res);
      } catch (e) {
        print(e);
      }
    }

    void _submit() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      callSendResetPassword();
      _formKey.currentState!.save();
    }

    return Scaffold(
      appBar: Toolbar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset password?',
                  style: AppText.header3,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please enter your validate code and new password and confirm the new password. Your email is $email',
                  style: AppText.paragraph3,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Code is required';
                      }
                      return null;
                    },
                    label: 'Enter your verification code',
                    controller: _verificationCode),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Id  is required';
                      }
                      return null;
                    },
                    label: 'Enter your id',
                    controller: _userId),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password is too short - should be min 6 chars';
                    }
                    return null;
                  },
                  label: 'New Password',
                  isPassword: true,
                  trailingIcon: Icons.remove_red_eye_outlined,
                  controller: _newPassword,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  validator: (value) {
                    if (value != _newPassword.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  label: 'Confirm new Password',
                  isPassword: true,
                  trailingIcon: Icons.remove_red_eye_outlined,
                  controller: _repetNewPassword,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Update new password',
                  onPressed: () => _submit(),
                  icon: Icons.arrow_right,
                  loading: loading,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
