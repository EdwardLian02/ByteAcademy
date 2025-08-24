import 'package:mini_course_frontend/model/courseModel.dart';
import 'package:mini_course_frontend/view/constant.dart';

class EnrollmentModel {
  final CourseModel course;
  final int enrollID;
  final double progress;
  final bool completed;
  final bool certificateIssued;
  final int? rating;
  final DateTime createdAt;

  EnrollmentModel({
    required this.course,
    required this.enrollID,
    required this.progress,
    required this.completed,
    required this.certificateIssued,
    this.rating,
    required this.createdAt,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> data) =>
      EnrollmentModel(
          course: CourseModel.fromJson(data['course']),
          enrollID: data['id'],
          progress: data['progress'],
          completed: data['completed'],
          certificateIssued: data['certificate_issued'],
          rating: data['rating'],
          createdAt: convertToDateTimeFormat(data['created_at']));
}
