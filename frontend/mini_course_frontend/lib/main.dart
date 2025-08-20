import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/AuthProvider.dart';
import 'package:mini_course_frontend/controller/courseProvider.dart';
import 'package:mini_course_frontend/view/components/courseContainer.dart';
import 'package:mini_course_frontend/view/screens/auth_screen.dart';
import 'package:mini_course_frontend/view/screens/courseDetail-screen.dart';
import 'package:mini_course_frontend/view/screens/home-screen.dart';
import 'package:mini_course_frontend/view/screens/login-screen.dart';
import 'package:mini_course_frontend/view/screens/register-screen.dart';
import 'package:mini_course_frontend/view/screens/splash-screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CourseProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text',
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
      routes: {
        'auth': (context) => AuthScreen(),
        'login': (context) => LoginScreen(),
        'register': (context) => RegisterScreen(),
        'home': (context) => HomeScreen(),
      },
    );
  }
}
