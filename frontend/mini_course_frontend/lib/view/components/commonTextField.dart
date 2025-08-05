import 'package:flutter/material.dart';
import 'package:mini_course_frontend/view/theme.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  const CommonTextField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
