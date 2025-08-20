import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mini_course_frontend/model/AuthResponse.dart';
import 'package:mini_course_frontend/model/secureStorage.dart';
import 'package:mini_course_frontend/model/tokenModel.dart';

class AuthenticationService {
  final String baseUrl = 'http://127.0.0.1:8000/';
  final secureStorage = SecureStorage();
  Future<TokenModel> login(
      {required String username, required password}) async {
    try {
      final response = await http.post(Uri.parse('${baseUrl}auth/jwt/create/'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': username,
            'password': password,
          }));
      print(response.body);

      if (response.statusCode == 200) {
        return TokenModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception("Something wrong while logging in");
      }
    } catch (e) {
      throw Exception("Something wrong while logging in");
    }
  }

  Future<bool> checkIsLogin() async {
    final access = await secureStorage.readData('access');
    final refresh = await secureStorage.readData('refresh');

    if (access == null && refresh == null) return false;

    if (JwtDecoder.isExpired(access!)) {
      print(
          "Too bad access token is expired! Need to get new access token with current refresh token");
      final newAccessToken = await refreshTokenLogic(refresh!);
      if (newAccessToken == null) {
        print(
            "Since refresh token also expired. gotta delete both token and let user login again");
        await secureStorage.deleteData('access');
        await secureStorage.deleteData('refresh');
        return false;
      } else {
        print("Got the new access token assign");
        await secureStorage.writeData("access", newAccessToken);
        return true;
      }
    }

    return true;
  }

  Future<String?> refreshTokenLogic(String refreshToken) async {
    try {
      print("Getting refresh token");
      final response = await http.post(Uri.parse("${baseUrl}auth/jwt/refresh"),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"refresh": refreshToken}));
      if (response.statusCode == 200) {
        print("yayy! Successfully gotten new access token");
        final decodedData = jsonDecode(response.body);
        return decodedData['access'];
      } else {
        print("Too bad: also refresh token is expired");
        return null;
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  //In service
  Future<AuthResponse> register(
      {required String email,
      required String username,
      required String password}) async {
    //Get the response
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/users/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'username': username,
          'password': password,
        }),
      );
      return AuthResponse(statusCode: response.statusCode);
    } catch (e) {
      throw Exception(
          'Something went wrong while registering with error ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await secureStorage.deleteData('access');
    await secureStorage.deleteData('refresh');
  }
}
