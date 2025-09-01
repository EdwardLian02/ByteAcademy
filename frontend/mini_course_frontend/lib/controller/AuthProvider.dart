import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/authenticationService.dart';
import 'package:mini_course_frontend/model/exception.dart';
import 'package:mini_course_frontend/model/secureStorage.dart';

class AuthProvider extends ChangeNotifier {
  final authSerivice = AuthenticationService();
  final secureStorage = SecureStorage();

  String? errorMessage;
  String? successMessage;

  bool isLoading = true;
  bool isLogin = false;

  Future<void> loginChecker() async {
    clearMessageAndVariable();
    try {
      final response = await authSerivice.checkIsLogin();
      isLogin = response;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginHandler({
    required String username,
    required String password,
  }) async {
    clearMessageAndVariable();

    try {
      //Response get TokenModel
      final response =
          await authSerivice.login(username: username, password: password);

      // Store tokens
      await secureStorage.writeData("access", response.accessToken);
      await secureStorage.writeData("refresh", response.refreshToken);

      //success message for ui
      successMessage = "Login success!";
      isLogin = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      print(errorMessage); // show whatever came from service
      notifyListeners();
    }
  }

  Future<void> logoutHandler() async {
    clearMessageAndVariable();
    try {
      await authSerivice.logout();
      isLogin = false;

      successMessage = "You have been logged out";
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void clearMessageAndVariable() {
    errorMessage = null;
    successMessage = null;
    isLoading = true;
  }

//in provider
  Future<void> signUpHandler(
      {required String email,
      required String username,
      required String password}) async {
    clearMessageAndVariable();
    notifyListeners();
    try {
      final result = await authSerivice.register(
        email: email,
        username: username,
        password: password,
      );

      if (result.statusCode == 201) {
        successMessage = "Account Created Successfully!";
      } else {
        errorMessage = "Account Creation Process Failed! Please Try Again.";
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();

      notifyListeners();
    }
  }
}
