import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/AuthProvider.dart';
import 'package:mini_course_frontend/view/components/commonButton.dart';
import 'package:mini_course_frontend/view/components/commonTextField.dart';
import 'package:mini_course_frontend/view/globel_widget.dart';
import 'package:mini_course_frontend/view/theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    if (_form.currentState!.validate()) {
      final provider = Provider.of<AuthProvider>(context, listen: false);

      showLoading(context);
      await provider.loginHandler(
          username: _nameController.text, password: _passwordController.text);

      if (!mounted) return;

      Navigator.pop(context);

      if (provider.errorMessage != null) {
        showMessage(context, provider.errorMessage!);
      } else if (provider.successMessage != null) {
        showMessage(context, provider.successMessage!);
      }
      Navigator.pushNamedAndRemoveUntil(
          context, 'home', (Route<dynamic> route) => false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 20,
        ),
        child: Form(
          key: _form,
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
                controller: _nameController,
                hintText: "Username",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "*This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CommonTextField(
                controller: _passwordController,
                hintText: "Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "*This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              CommonButton(
                onTap: login,
                label: "Log in",
                buttonBackgroundColor: AppTheme.boldbackground,
                buttonTextStyle: AppTheme.subheading2.copyWith(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
