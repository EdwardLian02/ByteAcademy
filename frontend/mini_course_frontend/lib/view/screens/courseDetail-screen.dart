import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/courseProvider.dart';
import 'package:mini_course_frontend/view/components/commonButton.dart';
import 'package:mini_course_frontend/view/theme.dart';
import 'package:provider/provider.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // IMAGE at the top
          Image.network(
            courseProvider.course.image ??
                'assets/images/course-sample-image.jpeg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),

          // Expanded scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(courseProvider.course.title, style: AppTheme.subheading),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 5),
                      Text('5.0', style: AppTheme.body),
                      SizedBox(width: 10),
                      Icon(Icons.access_time_filled),
                      SizedBox(width: 5),
                      Text('${courseProvider.course.totalDuration} hr',
                          style: AppTheme.body),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text('About Course', style: AppTheme.subheading2),
                  SizedBox(height: 20),
                  Text(
                    courseProvider.course!.description,
                    style: AppTheme.body,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Fixed enroll button at the bottom
          CommonButton(
            label: "Enroll Now",
            buttonTextStyle: AppTheme.subheading2.copyWith(color: Colors.white),
            buttonBackgroundColor: AppTheme.boldbackground,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
