// Custom TextField Widget
import 'package:flutter/material.dart';

import 'color_palette.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorPalette.accent, width: 1.5), // Color when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black, width: 2), // Color when focused
        ),
        labelText: label,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      obscureText: obscureText,
    );
  }
}
