import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_course_frontend/controller/authenticationService.dart';
import 'package:mini_course_frontend/model/secureStorage.dart';

final String baseUrl = 'http://127.0.0.1:8000/';
final authService = AuthenticationService();
final _secureStorage = SecureStorage();

//Return a new access token or null(if refresh token is also expired)
Future<String?> refreshAccessToken() async {
  //Fetch refresh token to get new accessToken
  final refreshToken = await _secureStorage.readData('refresh');
  print('getting refresh token cos access token is expired!');
  print(refreshToken);
  print("${baseUrl}auth/jwt/refresh/");
  try {
    //called the api
    final response = await http.post(
      Uri.parse("${baseUrl}auth/jwt/refresh/"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    //success if 200 statusCode
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccess = data['access'];
      print('got new access token');
      await _secureStorage.writeData('access', newAccess);
      return newAccess;
    } else {
      // Refresh failed → force user to login again
      print('got nothing, return null');
      return null;
    }
  } catch (e) {
    throw e.toString();
  }
}
