import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_course_frontend/model/tokenModel.dart';

class AuthenticationService {
  final String baseUrl = 'http://127.0.0.1:8000/api/';

  Future<TokenModel> login(
      {required String username, required password}) async {
    final response = await http.post(Uri.parse('${baseUrl}token/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }));

    if (response.statusCode == 200) {
      print('status code 200');
      final decodedData = jsonDecode(response.body);

      return TokenModel.fromJson(decodedData);
    } else {
      print('Something went wrong with status code ${response.statusCode}');
      throw Exception(
          'Something went wrong with status code ${response.statusCode}');
    }
  }
}
