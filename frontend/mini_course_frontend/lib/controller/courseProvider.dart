import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/apiService.dart';
import 'package:mini_course_frontend/controller/enrollmentProvider.dart';
import 'package:mini_course_frontend/model/courseModel.dart';
import 'package:mini_course_frontend/model/lessonModel.dart';

class CourseProvider extends ChangeNotifier {
  final apiService = APIService();
  final enrollmentProvider = EnrollmentProvider();
  List<dynamic> courseList = [];
  // late CourseModel course;
  String errorMessage = "";
  List<LessonModel> lessonList = [];

  //For detail screen
  int currentCourseId = 0;
  bool isAlreadyEnrolled = false;

  Future<void> getCourseList() async {
    try {
      print('fetching course');
      courseList = await apiService.fetchCourse();
      errorMessage = "";
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<CourseModel> getCourseDetail() async {
    return await apiService.fetchCourseDetail(currentCourseId);
  }

  Future<void> filtering(String para) async {
    if (para == 'All') {
      getCourseList();
      return;
    }
    try {
      courseList = await apiService.courseFiltering(para);
      errorMessage = "";
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
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

  void updateCurrentCourseInfo(int courseId, bool isAlreadyEnroll) {
    currentCourseId = courseId;
    isAlreadyEnrolled = isAlreadyEnroll;
    print(currentCourseId);
    print(isAlreadyEnroll);
    notifyListeners();
  }
}
