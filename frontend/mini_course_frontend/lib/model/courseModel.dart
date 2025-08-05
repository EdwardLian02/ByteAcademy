class CourseModel {
  int id;
  String title;
  String description;
  String? image;
  int totalDuration;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.totalDuration,
  });

  factory CourseModel.fromJson(Map<String, dynamic> data) => CourseModel(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        image: data['image'] ?? "",
        totalDuration: data['total_duration'],
      );

  static Map<String, dynamic> toJson(CourseModel course) => {
        'id': course.id,
        'title': course.title,
        'description': course.description,
        'image': course.image ?? "",
        'total_duration': course.totalDuration,
      };
}
