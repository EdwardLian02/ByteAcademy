import 'package:flutter/widgets.dart';
import 'package:mini_course_frontend/controller/apiService.dart';
import 'package:mini_course_frontend/view/screens/auth_screen.dart';

class SearchProvider extends ChangeNotifier {
  String searchKey = "";
  final _apiService = APIService();
  String errorMessage = "";
  String statusMessage = "";
  List<dynamic> courseList = [];

  Future<void> searchCourse() async {
    cleanVariable();
    try {
      courseList = await _apiService.searchCourse(searchKey);
      if (courseList.isEmpty) {
        statusMessage = "No search result found!";
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void cleanVariable() {
    errorMessage = "";
    statusMessage = "";
  }
}
