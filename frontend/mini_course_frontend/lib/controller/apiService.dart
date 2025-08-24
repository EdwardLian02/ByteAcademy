import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_course_frontend/model/courseModel.dart';
import 'package:mini_course_frontend/model/enrollmentModel.dart';
import 'package:mini_course_frontend/model/secureStorage.dart';

class APIService {
  final String baseUrl = 'http://127.0.0.1:8000/';
  final _secureStorage = SecureStorage();

  Future<List<dynamic>> fetchCourse() async {
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
      return courseList;
    } else {
      throw Exception("Something went wrong ");
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

  Future<List<EnrollmentModel>> fetchEnrollment() async {
    final token = await _secureStorage.readData('access');
    print(token);
    final response = await http.get(
      Uri.parse("${baseUrl}enrollment_api/enrollments/"),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final List<EnrollmentModel> enrollmentList = [];
      final decodeData = jsonDecode(response.body);
      print(decodeData);
      for (Map<String, dynamic> enrollment in decodeData) {
        enrollmentList.add(EnrollmentModel.fromJson(enrollment));
      }
      return enrollmentList;
    } else {
      throw Exception("Something went wrong ");
    }
  }
}
