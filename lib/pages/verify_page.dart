import 'package:flutter/material.dart';
import 'package:flutter_application_auth/components/app_button.dart';
import 'package:flutter_application_auth/components/app_text_field.dart';
import 'package:flutter_application_auth/components/app_toast.dart';
import 'package:flutter_application_auth/components/toolbar.dart';
import 'package:flutter_application_auth/config/app_routes.dart';
import 'package:flutter_application_auth/services/user_service.dart';
import 'package:flutter_application_auth/styles/app_colors.dart';
import 'package:flutter_application_auth/styles/app_text.dart';

class VerifyPage extends StatefulWidget {
  VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

bool loading = false;

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController _verificationCode = TextEditingController();

  @override
  void dispose() {
    _verificationCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final email = arguments['email'];

    void verifyUser() async {
      setState(() {
        loading = true;
      });
      try {
        final res = await UserService.verify(email, _verificationCode.text);
        if (res) {
          CustomToast.show(message: 'User successfully verify');
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        } else {
          CustomToast.show(
              message: 'Could not verify user,please chech your email');
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        loading = false;
      });
    }

    return Scaffold(
      appBar: Toolbar(title: ''),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verification code?',
              style: AppText.header3,
            ),
            SizedBox(height: 10),
            Text(
              'We have sent you a verification code to your email : $email,please check?',
              style: AppText.paragraph1,
            ),
            SizedBox(height: 20),
            CustomTextField(
                label: 'enter your code for verification',
                controller: _verificationCode),
            SizedBox(height: 20),
            CustomButton(
                text: 'Verify',
                icon: Icons.arrow_right,
                loading: loading,
                onPressed: () => verifyUser()),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Didn’t received the code?',
                  style: AppText.paragraph1,
                ),
                SizedBox(
                  width: 5,
                ),
                const Text(
                  'Resend Code',
                  style: TextStyle(color: AppColors.primary),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
