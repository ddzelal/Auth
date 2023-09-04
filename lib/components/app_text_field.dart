import 'package:flutter/material.dart';
import 'package:flutter_application_auth/styles/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final ValueChanged<String>? onChange;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Dodali smo validator

  const CustomTextField({
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.onChange,
    this.isPassword,
    this.controller,
    this.validator, // Dodali smo validator
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.dark5, width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          if (widget.leadingIcon != null)
            Icon(widget.leadingIcon, color: AppColors.dark3),
          SizedBox(width: 8.0),
          Expanded(
            child: TextFormField(
              validator: widget.validator,
              controller: widget.controller,
              obscureText: _obscureText,
              onChanged: widget.onChange,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.label,
              ),
            ),
          ),
          if (widget.trailingIcon != null)
            GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(widget.trailingIcon, color: AppColors.dark3),
            ),
        ],
      ),
    );
  }
}
