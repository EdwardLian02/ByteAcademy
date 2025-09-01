import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_course_frontend/controller/authenticationService.dart';
import 'package:mini_course_frontend/controller/tokenHelper.dart';
import 'package:mini_course_frontend/model/courseModel.dart';
import 'package:mini_course_frontend/model/enrollmentModel.dart';
import 'package:mini_course_frontend/model/secureStorage.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class APIService {
  final String baseUrl = 'http://127.0.0.1:8000/';
  final _secureStorage = SecureStorage();
  final _authService = AuthenticationService();

  Future<List<dynamic>> fetchCourse() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}course_api/courses/"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> courseList = [];
        final decodeData = jsonDecode(response.body);

        for (Map<String, dynamic> course in decodeData) {
          courseList.add(CourseModel.fromJson(course));
        }
        print(courseList);
        return courseList;
      } else {
        throw Exception("Something went wrong while fetching courses ");
      }
    } catch (e) {
      throw Exception("Connection Error! Please Try Again Later");
    }
  }

  Future<CourseModel> fetchCourseDetail(id) async {
    final response =
        await http.get(Uri.parse('${baseUrl}course_api/courses/$id'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      print('course detail');
      print(decodeData);
      return CourseModel.fromJson(decodeData);
    } else {
      throw Exception('something went wrong!');
    }
  }

  Future<List<dynamic>> courseFiltering(String para) async {
    final response = await http
        .get(Uri.parse('${baseUrl}course_api/courses?gener=$para'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> courseList = [];
      final decodeData = jsonDecode(response.body);

      for (Map<String, dynamic> course in decodeData) {
        courseList.add(CourseModel.fromJson(course));
      }
      return courseList;
    } else {
      print(response.body);
      throw Exception('something went wrong');
    }
  }

  Future<List<dynamic>> searchCourse(String searchKey) async {
    final response = await http.get(
        Uri.parse('${baseUrl}course_api/courses?search=$searchKey'),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      final List<dynamic> courseList = [];
      final decodeData = jsonDecode(response.body);

      for (Map<String, dynamic> course in decodeData) {
        courseList.add(CourseModel.fromJson(course));
      }

      return courseList;
    } else {
      print(response.body);
      throw Exception('something went wrong while searching');
    }
  }

  Future<List<EnrollmentModel>> fetchEnrollment() async {
    String? accessToken = await _secureStorage.readData('access');

    if (JwtDecoder.isExpired(accessToken!)) {
      await refreshAccessToken();
    }
    var response = await http.get(
      Uri.parse("${baseUrl}enrollment_api/enrollments/"),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 401) {
      // Try refreshing the token
      final newAccess = await refreshAccessToken();
      if (newAccess != null) {
        response = await http.get(
          Uri.parse("${baseUrl}enrollment_api/enrollments/"),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $newAccess',
          },
        );
      } else {
        throw Exception("Session expired, please log in again.");
      }
    }

    if (response.statusCode == 200) {
      final List<EnrollmentModel> enrollmentList = [];
      final decodeData = jsonDecode(response.body);
      for (Map<String, dynamic> enrollment in decodeData) {
        enrollmentList.add(EnrollmentModel.fromJson(enrollment));
      }
      return enrollmentList;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<Map<String, dynamic>> createEnrollment(int courseId) async {
    String? accessToken = await _secureStorage.readData('access');

    if (JwtDecoder.isExpired(accessToken!)) {
      await refreshAccessToken();
    }

    try {
      final response =
          await http.post(Uri.parse('${baseUrl}enrollment_api/enrollments/'),
              headers: {
                "Content-Type": 'application/json',
                'authorization': 'Bearer $accessToken',
              },
              body: json.encode({
                "course": courseId,
              }));
      return {'status': response.statusCode};
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
