import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/apiService.dart';
import 'package:mini_course_frontend/model/courseModel.dart';
import 'package:mini_course_frontend/model/lessonModel.dart';

class CourseProvider extends ChangeNotifier {
  final apiService = APIService();
  List<dynamic> courseList = [];
  // late CourseModel course;
  String errorMessage = "";
  List<LessonModel> lessonList = [];

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

  Future<CourseModel> getCourseDetail(id) async {
    return await apiService.fetchCourseDetail(id);
  }

  //Update Lesson list
  void updateLessonList(List<dynamic> lessonData) {
    lessonList.clear();
    print(lessonData);
    for (Map<String, dynamic> lesson in lessonData) {
      lessonList.add(LessonModel.fromJson(lesson));
    }
    notifyListeners();
  }
}
