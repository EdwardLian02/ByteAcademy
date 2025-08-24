import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/apiService.dart';
import 'package:mini_course_frontend/model/enrollmentModel.dart';

class EnrollmentProvider extends ChangeNotifier {
  List<EnrollmentModel> enrollmentList = [];
  final _apiService = APIService();

  Future<void> fetchEnrollment() async {
    final list = await _apiService.fetchEnrollment();
    enrollmentList = list;
    notifyListeners();
  }
}
