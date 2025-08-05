import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/authenticationService.dart';
import 'package:mini_course_frontend/model/secureStorage.dart';

class AuthProvider extends ChangeNotifier {
  final authSerivice = AuthenticationService();
  final secureStorage = SecureStorage();
  String errorMessage = "";

  Future<void> loginHandler(
      {required String username, required password}) async {
    // try {
    final tokenData =
        await authSerivice.login(username: username, password: password);
    print("before writing token data");
    secureStorage.writeData('accessToken', tokenData.accessToken);
    secureStorage.writeData('refreshToken', tokenData.refreshToken);

    print("Finish writing token data");
    print(secureStorage.readData('accessToken'));
    print(secureStorage.readData('refreshToken'));
    // } catch (e) {
    //   print(e);
    //   errorMessage = e.toString();
    //   notifyListeners();
    // }
  }
}
