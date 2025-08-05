import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mini_course_frontend/view/components/commonButton.dart';
import 'package:mini_course_frontend/view/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.boldbackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash-icon.png'),
            SizedBox(height: 25),
            Text(
              'ByteAcademy',
              style: AppTheme.subheading.copyWith(color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Learn easy and fast with ByteAcademy\nWatch Video Learning Anytime',
              style: AppTheme.body.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            CommonButton(
              label: "Log in",
              buttonTextStyle: AppTheme.subheading2,
              onTap: () => Navigator.pushNamed(context, 'login'),
            ),
            SizedBox(height: 10),
            CommonButton(
              label: "Sign Up",
              buttonTextStyle: AppTheme.subheading2.copyWith(
                color: Colors.white,
              ),
              onTap: () => Navigator.pushNamed(context, 'register'),
              buttonBackgroundColor: Color(0XFFFFFFFF).withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
