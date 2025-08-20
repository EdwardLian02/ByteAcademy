import 'package:flutter/material.dart';
import 'package:mini_course_frontend/view/theme.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const CommonTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: AppTheme.lighbackground,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey,
          ))),
    );
  }
}
