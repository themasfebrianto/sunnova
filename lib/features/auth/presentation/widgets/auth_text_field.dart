import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AuthTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
