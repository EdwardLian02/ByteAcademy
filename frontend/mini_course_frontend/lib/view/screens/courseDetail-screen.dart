import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/courseProvider.dart';
import 'package:mini_course_frontend/controller/enrollmentProvider.dart';
import 'package:mini_course_frontend/view/components/commonButton.dart';
import 'package:mini_course_frontend/view/components/generBlock.dart';
import 'package:mini_course_frontend/view/globel_widget.dart';
import 'package:mini_course_frontend/view/screens/lesson_screen.dart';
import 'package:mini_course_frontend/view/theme.dart';
import 'package:provider/provider.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: courseProvider.getCourseDetail(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final course = snapshot.data;
          return Column(
            children: [
              // IMAGE at the top
              Image.network(
                course!.image ?? 'assets/images/course-sample-image.jpeg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),

              // Expanded scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Consumer<CourseProvider>(
                    builder: (context, courseProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(course.title, style: AppTheme.subheading),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 5),
                              Text('5.0', style: AppTheme.body),
                              SizedBox(width: 10),
                              Icon(Icons.access_time_filled),
                              SizedBox(width: 5),
                              Text('${course.totalDuration} hr',
                                  style: AppTheme.body),
                            ],
                          ),
                          SizedBox(height: 10),
                          Generblock(),
                          SizedBox(height: 10),
                          Text(
                            'Total Lessons: ${course.totalLessons}',
                            style: AppTheme.body,
                          ),
                          SizedBox(height: 40),
                          Text('About Course', style: AppTheme.subheading2),
                          SizedBox(height: 20),
                          Text(
                            course.description!,
                            style: AppTheme.body,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 40),
                        ],
                      );
                    },
                  ),
                ),
              ),

              // Fixed enroll button at the bottom
              Visibility(
                visible: !courseProvider.isAlreadyEnrolled,
                child: CommonButton(
                  label: "Enroll Now",
                  buttonTextStyle:
                      AppTheme.subheading2.copyWith(color: Colors.white),
                  buttonBackgroundColor: AppTheme.boldbackground,
                  onTap: () async {
                    print('hi');
                    final message = await enrollmentProvider
                        .createEnrollment(courseProvider.currentCourseId);

                    if (enrollmentProvider.message['isSuccess']) {
                      print('enrolled success');
                      courseProvider.updateCurrentCourseInfo(
                          courseProvider.currentCourseId, true);
                      showMessage(
                          context, enrollmentProvider.message['message']);
                    } else {
                      showMessage(
                          context, enrollmentProvider.message['message']);
                    }
                  },
                ),
              ),

              Visibility(
                  visible: courseProvider.isAlreadyEnrolled,
                  child: CommonButton(
                      label: "Start Learn",
                      buttonTextStyle:
                          AppTheme.subheading2.copyWith(color: Colors.white),
                      buttonBackgroundColor: AppTheme.boldbackground,
                      onTap: () {
                        courseProvider.updateLessonList(course.lessonList!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LessonScreen(courseInfo: course)));
                      })),
              SizedBox(
                height: 20,
              )
            ],
          );
        },
      ),
    );
  }
}
