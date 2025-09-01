import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/AuthProvider.dart';
import 'package:mini_course_frontend/controller/authenticationService.dart';
import 'package:mini_course_frontend/view/screens/home-screen.dart';
import 'package:mini_course_frontend/view/screens/login-screen.dart';
import 'package:mini_course_frontend/view/screens/progress_screen.dart';
import 'package:mini_course_frontend/view/screens/splash-screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callIsCheck();
  }

  void callIsCheck() async {
    await Provider.of<AuthProvider>(context, listen: false).loginChecker();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return ProgressScreen();
        }
        return value.isLogin ? HomeScreen() : SplashScreen();
      },
    );
  }
}
