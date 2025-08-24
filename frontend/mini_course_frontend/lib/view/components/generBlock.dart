import 'package:flutter/material.dart';
import 'package:mini_course_frontend/view/theme.dart';

class Generblock extends StatelessWidget {
  const Generblock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Programming",
          style: AppTheme.body.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
