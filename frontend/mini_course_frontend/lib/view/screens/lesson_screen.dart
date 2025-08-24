import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/courseProvider.dart';
import 'package:mini_course_frontend/model/courseModel.dart';
import 'package:mini_course_frontend/view/components/lesson_tile.dart';
import 'package:mini_course_frontend/view/screens/youtube_video_player.dart';
import 'package:mini_course_frontend/view/theme.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatefulWidget {
  final CourseModel courseInfo;
  const LessonScreen({super.key, required this.courseInfo});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Consumer<CourseProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                Center(
                    child: Text(
                  widget.courseInfo.title,
                  style: AppTheme.subheading2,
                  textAlign: TextAlign.center,
                )),
                Center(
                  child: Text(
                    "${widget.courseInfo.totalDuration}",
                    style: AppTheme.subheading3.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.lessonList.length,
                    itemBuilder: (context, index) {
                      final lesson = value.lessonList[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                YoutubeVideoPlayer(url: lesson.url),
                          ),
                        ),
                        child: LessonTile(
                            title: lesson.name,
                            totalDuration: lesson.videoDuraton,
                            image: "assets/images/course-sample-image.jpeg"),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
