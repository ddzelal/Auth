import 'package:flutter/material.dart';
import 'package:flutter_application_auth/components/app_button.dart';
import 'package:flutter_application_auth/components/app_text_field.dart';
import 'package:flutter_application_auth/components/app_toast.dart';
import 'package:flutter_application_auth/components/toolbar.dart';
import 'package:flutter_application_auth/config/app_routes.dart';
import 'package:flutter_application_auth/config/app_strings.dart';
import 'package:flutter_application_auth/model/register.model.dart';
import 'package:flutter_application_auth/services/user_service.dart';
import 'package:flutter_application_auth/styles/app_colors.dart';
import 'package:flutter_application_auth/styles/app_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

bool loading = false;

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void registerUser() async {
      setState(() {
        loading = true;
      });
      try {
        // Remove this line - this is for test
        // await Future.delayed(const Duration(seconds: 1));
        final res = await UserService.register(
            context,
            RegisterModelRequest(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                passwordConfirmation: _repeatPasswordController.text));
        if (res) {
          CustomToast.show(
              message: 'User successfully created, please verify your account');
          Navigator.pushNamed(context, AppRoutes.verifyPage,
              arguments: {'email': _emailController.text});
        } else {
          CustomToast.show(message: 'Account already exists');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registration failed: $e'), // Display the error message
        ));
      }
      setState(() {
        loading = false;
      });
    }

    void _submit() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      registerUser();
      _formKey.currentState!.save();
    }

    return Scaffold(
      appBar: const Toolbar(title: AppStrings.register),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: AppColors.backgroundApp),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.createAccount,
                  style: AppText.header3,
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'First name is required';
                          }
                          return null;
                        },
                        label: AppStrings.firstName,
                        leadingIcon: Icons.person,
                        controller: _firstNameController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Last name is required';
                          }
                          return null;
                        },
                        label: AppStrings.lastName,
                        leadingIcon: Icons.person,
                        controller: _lastNameController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                        label: AppStrings.email,
                        leadingIcon: Icons.email,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password is too short - should be min 6 chars';
                          }
                          return null;
                        },
                        label: AppStrings.password,
                        leadingIcon: Icons.lock,
                        trailingIcon: Icons.visibility,
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        label: 'Repet password',
                        leadingIcon: Icons.lock,
                        trailingIcon: Icons.visibility,
                        isPassword: true,
                        controller: _repeatPasswordController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    text: AppStrings.register,
                    icon: Icons.app_registration,
                    onPressed: () => _submit(),
                    loading: loading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
