import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/apiService.dart';
import 'package:mini_course_frontend/model/courseModel.dart';

class CourseProvider extends ChangeNotifier {
  final apiService = APIService();
  List<dynamic> courseList = [];
  late CourseModel course;
  String errorMessage = "";

  Future<void> getCourseList() async {
    try {
      courseList = await apiService.fetchCourse();
      errorMessage = "";
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> getCourseDetail(id) async {
    course = await apiService.fetchCourseDetail(id);
    notifyListeners();
  }
}
