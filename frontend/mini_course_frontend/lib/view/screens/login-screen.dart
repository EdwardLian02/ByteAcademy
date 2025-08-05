import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/AuthProvider.dart';
import 'package:mini_course_frontend/view/components/commonButton.dart';
import 'package:mini_course_frontend/view/components/commonTextField.dart';
import 'package:mini_course_frontend/view/theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Hello,", style: AppTheme.body),
            Text(
              'Welcome Back!',
              style: AppTheme.subheading,
            ),
            SizedBox(height: 50),
            Center(
              child: Image.asset(
                'assets/images/splash-icon.png',
                width: 200,
              ),
            ),
            SizedBox(height: 70),
            CommonTextField(
              hintText: "Username",
            ),
            SizedBox(height: 10),
            CommonTextField(
              hintText: "Password",
            ),
            SizedBox(height: 30),
            CommonButton(
              onTap: () async {
                print('hi');
                await Provider.of<AuthProvider>(context, listen: false)
                    .loginHandler(username: "admin", password: "admin12345");
              },
              label: "Log in",
              buttonBackgroundColor: AppTheme.boldbackground,
              buttonTextStyle: AppTheme.subheading2.copyWith(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
