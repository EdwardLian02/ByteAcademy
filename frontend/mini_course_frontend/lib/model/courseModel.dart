import 'package:mini_course_frontend/model/lessonModel.dart';

class CourseModel {
  int id;
  String title;
  String? description;
  String? image;
  int totalDuration;
  int? totalLessons;
  List<dynamic>? lessonList;

  CourseModel({
    required this.id,
    required this.title,
    this.description,
    this.image,
    this.totalLessons,
    required this.totalDuration,
    this.lessonList,
  });

  factory CourseModel.fromJson(Map<String, dynamic> data) => CourseModel(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        image: data['image'] ?? "",
        totalDuration: data['total_duration'],
        totalLessons: data['total_lessons'],
        lessonList: data['lesson_set'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image ?? "",
        'total_duration': totalDuration,
        'total_lessons': totalLessons,
        'lesson_set': lessonList,
      };
}
