import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/AuthProvider.dart';
import 'package:mini_course_frontend/controller/apiService.dart';
import 'package:mini_course_frontend/controller/courseProvider.dart';
import 'package:mini_course_frontend/view/components/courseContainer.dart';
import 'package:mini_course_frontend/view/components/courseTile.dart';
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

  void fetchCoureDetail(id) async {
    await context.read<CourseProvider>().getCourseDetail(id);
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
            MySearchBar(),
            CourseContainer(),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Course', style: AppTheme.subheading),
                Text('See more', style: AppTheme.body),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<CourseProvider>(
                builder: (context, value, child) {
                  if (value.errorMessage != "") {
                    return Center(
                      child: Text(value.errorMessage),
                    );
                  } else {
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
                                  builder: (context) => CourseDetailScreen(
                                    id: course.id,
                                  ),
                                ));
                          },
                          child: CourseTile(
                            title: course.title,
                            totalDuration: course.totalDuration,
                            image: course.image,
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
