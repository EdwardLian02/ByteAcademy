import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/courseProvider.dart';
import 'package:mini_course_frontend/controller/enrollmentProvider.dart';
import 'package:mini_course_frontend/controller/searchProvider.dart';
import 'package:mini_course_frontend/view/components/courseTile.dart';
import 'package:mini_course_frontend/view/components/searchbar.dart';
import 'package:mini_course_frontend/view/screens/courseDetail-screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void fetchCoureDetail(id) async {
    await context.read<CourseProvider>().getCourseDetail();
  }

  bool checkIsEnrolled(int courseId) {
    return Provider.of<EnrollmentProvider>(context)
        .userEnrolledCourseId
        .contains(courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Consumer<SearchProvider>(builder: (context, value, child) {
                if (value.statusMessage.isNotEmpty) {
                  return Text(value.statusMessage);
                }
                if (value.errorMessage.isNotEmpty) {
                  return Text(
                    value.errorMessage,
                    style: TextStyle(color: Colors.red),
                  );
                }
                return ListView.builder(
                  itemCount: value.courseList.length,
                  itemBuilder: (context, index) {
                    final course = value.courseList[index];
                    return GestureDetector(
                      onTap: () async {
                        fetchCoureDetail(course.id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(),
                            ));
                      },
                      child: CourseTile(
                        title: course.title,
                        totalDuration: course.totalDuration,
                        image: course.image,
                        isAlreadyEnrolled: checkIsEnrolled(course.id),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
