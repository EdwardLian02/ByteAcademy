import 'package:flutter/material.dart';
import 'package:mini_course_frontend/view/theme.dart';

class LessonTile extends StatelessWidget {
  final String title;
  final String image;
  final int totalDuration;

  const LessonTile({
    super.key,
    required this.title,
    required this.totalDuration,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              15,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    image,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Text(
                    title,
                    style: AppTheme.subheading2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Text('$totalDuration hr', style: AppTheme.body),
            ],
          ),
        ),
      ),
    );
  }
}
