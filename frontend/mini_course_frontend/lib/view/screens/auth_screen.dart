import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/AuthProvider.dart';
import 'package:mini_course_frontend/controller/authenticationService.dart';
import 'package:mini_course_frontend/view/screens/home-screen.dart';
import 'package:mini_course_frontend/view/screens/login-screen.dart';
import 'package:mini_course_frontend/view/screens/progress_screen.dart';
import 'package:mini_course_frontend/view/screens/splash-screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthenticationService().checkIsLogin(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return ProgressScreen();
        } else {
          if (snapshot.data == true) {
            return HomeScreen();
          } else {
            return SplashScreen();
          }
        }
      },
    );
  }
}
