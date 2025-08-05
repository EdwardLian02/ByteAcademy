import 'package:flutter/material.dart';
import 'package:mini_course_frontend/view/theme.dart';

class CourseTile extends StatelessWidget {
  final String title;
  final String image;
  final int totalDuration;

  const CourseTile({
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
              Image.network(
                image,
                width: 130,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.subheading2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 5),
                        Text('0.0', style: AppTheme.body),
                        SizedBox(width: 20),
                        Icon(Icons.access_time_filled),
                        SizedBox(width: 5),
                        Text('$totalDuration hr', style: AppTheme.body),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
