import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/enrollmentProvider.dart';
import 'package:mini_course_frontend/view/components/enrollment_tile.dart';
import 'package:mini_course_frontend/view/components/my_drawer.dart';
import 'package:mini_course_frontend/view/screens/lesson_screen.dart';
import 'package:mini_course_frontend/view/theme.dart';
import 'package:provider/provider.dart';

class EnrollmentScreen extends StatefulWidget {
  const EnrollmentScreen({super.key});

  @override
  State<EnrollmentScreen> createState() => _EnrollmentScreenState();
}

class _EnrollmentScreenState extends State<EnrollmentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllEnrollments();
  }

  void getAllEnrollments() async {
    await context.read<EnrollmentProvider>().fetchEnrollment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<EnrollmentProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Courses",
                  style: AppTheme.subheading,
                ),
                SizedBox(height: 20),
                Expanded(
                    child: ListView.builder(
                  itemCount: provider.enrollmentList.length,
                  itemBuilder: (context, index) {
                    final enroll = provider.enrollmentList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: EnrollmentTile(
                        courseTitle: enroll.course.title,
                        totalDuration: enroll.course.totalDuration,
                        progress: enroll.progress,
                        imageUrl: enroll.course.image!,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LessonScreen(
                                  courseInfo: enroll.course,
                                ),
                              ));
                        },
                      ),
                    );
                  },
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}
