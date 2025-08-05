import 'package:flutter/material.dart';
import 'package:mini_course_frontend/view/theme.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  final Color buttonBackgroundColor;
  final TextStyle buttonTextStyle;
  const CommonButton({
    super.key,
    required this.label,
    required this.buttonTextStyle,
    this.buttonBackgroundColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            label,
            style: buttonTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
