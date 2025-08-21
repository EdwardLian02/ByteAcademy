import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/AuthProvider.dart';
import 'package:mini_course_frontend/model/userModel.dart';
import 'package:mini_course_frontend/view/components/commonButton.dart';
import 'package:mini_course_frontend/view/components/commonTextField.dart';
import 'package:mini_course_frontend/view/globel_widget.dart';
import 'package:mini_course_frontend/view/theme.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void register() async {
    if (_form.currentState!.validate()) {
      final provider = Provider.of<AuthProvider>(context, listen: false);
      showLoading(context);
      await provider.signUpHandler(
          email: _emailController.text,
          username: _nameController.text,
          password: _passwordController.text);

      if (!mounted) return;
      Navigator.pop(context);
      if (provider.errorMessage != null) {
        showMessage(context, provider.errorMessage!);
      } else if (provider.successMessage != null) {
        showMessage(context, provider.successMessage!);
        Navigator.pushNamedAndRemoveUntil(
            context, "login", (Route<dynamic> route) => false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 20,
          ),
          child: Form(
            key: _form,
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Hello, pal", style: AppTheme.body),
                    Text(
                      'Welcome Here!',
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
                      controller: _emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "*This field is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
                    CommonTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "*This field is required";
                        }

                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          return "*Confirmed password need to be same with password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    CommonButton(
                      onTap: register,
                      label: "Sign up",
                      buttonBackgroundColor: AppTheme.boldbackground,
                      buttonTextStyle: AppTheme.subheading2.copyWith(
                        color: Colors.white,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
