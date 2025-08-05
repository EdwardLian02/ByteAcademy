import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_course_frontend/model/courseModel.dart';

class APIService {
  final String baseUrl = 'http://127.0.0.1:8000/api/';

  Future<List<dynamic>> fetchCourse() async {
    final response = await http.get(
      Uri.parse("${baseUrl}courses"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> courseList = [];
      final decodeData = jsonDecode(response.body);
      print(decodeData);
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
        await http.get(Uri.parse('${baseUrl}course/$id'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      return CourseModel.fromJson(decodeData);
    } else {
      throw Exception('something went wrong!');
    }
  }
}
