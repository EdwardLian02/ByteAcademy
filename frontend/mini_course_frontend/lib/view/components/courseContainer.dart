import 'package:flutter/material.dart';
import 'package:mini_course_frontend/controller/apiService.dart';
import 'package:mini_course_frontend/view/theme.dart';

class CourseContainer extends StatelessWidget {
  const CourseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/course-sample-image2.jpeg',
            width: 400,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 25,
          left: 20,
          child: Text(
            "New Course!",
            style: AppTheme.subheading.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 20,
          child: Text(
            "User Experience Class",
            style: AppTheme.body.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 20,
          child: TextButton(
            onPressed: () async {
              await APIService().fetchCourse();
              print("finished!!");
            },
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color.fromRGBO(0, 0, 0, 225),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
            child: Text('Explore',
                style: AppTheme.body.copyWith(
                  color: Colors.white,
                )),
          ),
        )
      ],
    );
  }
}
