import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/apiService.dart';
import 'package:mini_course_frontend/model/enrollmentModel.dart';
import 'package:mini_course_frontend/model/lessonModel.dart';

class EnrollmentProvider extends ChangeNotifier {
  List<EnrollmentModel> enrollmentList = [];
  List<LessonModel> lessonList = [];
  final _apiService = APIService();
  List userEnrolledCourseId = [];
  Map<String, dynamic> message = {};

  Future<void> fetchEnrollment() async {
    print('fetching enrollment');
    final list = await _apiService.fetchEnrollment();
    enrollmentList = list;
    //Fetch the user already enrolled course ID from enrollment.
    print('adding user enrolled course ID');
    for (EnrollmentModel enroll in enrollmentList) {
      userEnrolledCourseId.add(enroll.course.id);
    }
    notifyListeners();
  }

  Future<void> createEnrollment(int id) async {
    try {
      final messageMap = await _apiService.createEnrollment(id);

      if (messageMap['status'] == 201) {
        await fetchEnrollment();
        message['isSuccess'] = true;
        message['message'] = 'You\'ve successfully enrolled this course';
      } else {
        message['isSuccess'] = false;
        message['message'] = 'I dont know maybe some issues from the backend ';
      }
    } catch (e) {
      message['isSuccess'] = false;
      message['message'] = 'Something went wrong while enroll';
    }
  }
}
