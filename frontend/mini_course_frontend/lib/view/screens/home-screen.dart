import 'package:mini_course_frontend/controller/AuthProvider.dart';

import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/courseProvider.dart';
import 'package:mini_course_frontend/controller/enrollmentProvider.dart';
import 'package:mini_course_frontend/controller/searchProvider.dart';
import 'package:mini_course_frontend/view/components/courseContainer.dart';
import 'package:mini_course_frontend/view/components/courseTile.dart';
import 'package:mini_course_frontend/view/components/filter_dropdown.dart';
import 'package:mini_course_frontend/view/components/my_drawer.dart';
import 'package:mini_course_frontend/view/components/searchbar.dart';
import 'package:mini_course_frontend/view/globel_widget.dart';
import 'package:mini_course_frontend/view/screens/courseDetail-screen.dart';
import 'package:mini_course_frontend/view/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchCourses();
    fetchEnrollment();
  }

  void logout() async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    showLoading(context);
    await provider.logoutHandler();

    if (!mounted) return;
    if (provider.errorMessage != null) {
      showMessage(context, provider.errorMessage!);
    } else if (provider.successMessage != null) {
      showMessage(context, provider.successMessage!);
    }
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
        context, 'auth', (Route<dynamic> route) => false);
  }

  void fetchCourses() async {
    await context.read<CourseProvider>().getCourseList();
  }

  void fetchEnrollment() async {
    await context.read<EnrollmentProvider>().fetchEnrollment();
  }

  void fetchCoureDetail() async {
    await context.read<CourseProvider>().getCourseDetail();
  }

  bool checkIsEnrolled(int courseId) {
    print("Course ID: $courseId");
    final result = Provider.of<EnrollmentProvider>(context, listen: false)
        .userEnrolledCourseId
        .contains(courseId);
    print("Is Enrolled? : $result");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 20),
        backgroundColor: AppTheme.lighbackground,
        actions: [
          CircleAvatar(),
        ],
      ),
      drawer: MyDrawer(),
      backgroundColor: AppTheme.lighbackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Hello, Students",
              style: AppTheme.subheading,
            ),
            Text(
              'What do you want to learn?',
              style: AppTheme.body,
            ),
            SizedBox(height: 10),
            Hero(
              tag: "searchBar",
              child: MySearchBar(
                onSubmitted: () {
                  Provider.of<SearchProvider>(context, listen: false)
                      .searchCourse();
                  Navigator.pushNamed(context, 'search');
                },
                onChanged: (value) {
                  Provider.of<SearchProvider>(context, listen: false)
                      .searchKey = value;
                  print(value);
                },
              ),
            ),
            CourseContainer(),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Course', style: AppTheme.subheading),
                FilterDropdown(
                  icon: Icons.filter_alt,
                  items: [
                    "All",
                    "Programming Language",
                    "AI",
                    "Data Science & Analytics"
                  ],
                  initialValue: "All",
                  onChanged: (value) async {
                    await Provider.of<CourseProvider>(context, listen: false)
                        .filtering(value);
                    print('finished filtering');
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<CourseProvider>(
                builder: (context, value, child) {
                  if (value.errorMessage != "") {
                    return Center(
                      child: Text(
                        value.errorMessage,
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: value.courseList.length,
                      itemBuilder: (context, index) {
                        final course = value.courseList[index];
                        return GestureDetector(
                          onTap: () async {
                            Provider.of<CourseProvider>(context, listen: false)
                                .updateCurrentCourseInfo(
                                    course.id, checkIsEnrolled(course.id));
                            fetchCoureDetail();

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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
