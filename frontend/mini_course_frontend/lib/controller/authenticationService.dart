import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mini_course_frontend/controller/tokenHelper.dart';
import 'package:mini_course_frontend/model/AuthResponse.dart';
import 'package:mini_course_frontend/model/exception.dart';
import 'package:mini_course_frontend/model/secureStorage.dart';
import 'package:mini_course_frontend/model/tokenModel.dart';

class AuthenticationService {
  final String baseUrl = 'http://127.0.0.1:8000/';
  final secureStorage = SecureStorage();
  Future<TokenModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}auth/jwt/create/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return TokenModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        final body = jsonDecode(response.body);
        final detail = body['detail'] ?? 'Login failed';
        print('print out ex');
        print(detail);
        throw detail; // just throw the backend message
      }
    } on http.ClientException {
      throw Exception("Network error. Please check your internet.");
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkIsLogin() async {
    //Get the stored key
    final access = await secureStorage.readData('access');
    final refresh = await secureStorage.readData('refresh');

    print('access token: $access');
    print('refresh token: $refresh');
    //if both key is null, logout
    if (access == null && refresh == null) return false;

    //if access is not expired, then simply return true
    if (!JwtDecoder.isExpired(access!)) {
      print("Access token is not expired!");
      return true;
    }

    //Mean: access token is expired. and need to get a new token
    try {
      final newToken = await refreshAccessToken();
      if (newToken == null) {
        await logout();
        return false;
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
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
