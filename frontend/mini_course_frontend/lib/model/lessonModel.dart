class LessonModel {
  final String name;
  final int videoDuraton;
  final String url;

  LessonModel({
    required this.name,
    required this.videoDuraton,
    required this.url,
  });

  factory LessonModel.fromJson(Map<String, dynamic> data) => LessonModel(
      name: data['name'],
      videoDuraton: data['video_duration'],
      url: data['url']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'video_duration': videoDuraton,
        'url': url,
      };
}
