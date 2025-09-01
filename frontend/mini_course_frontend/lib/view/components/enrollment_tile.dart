import 'package:flutter/material.dart';
import 'package:mini_course_frontend/view/components/commonButton.dart';
import 'package:mini_course_frontend/view/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class EnrollmentTile extends StatelessWidget {
  final String courseTitle;
  final int totalDuration;
  final double progress;
  final String imageUrl;
  final void Function()? onPressed;
  const EnrollmentTile(
      {super.key,
      required this.courseTitle,
      required this.totalDuration,
      required this.progress,
      required this.imageUrl,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.blueGrey.shade100,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color with opacity
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            LinearPercentIndicator(
              barRadius: Radius.circular(20),
              progressColor: Colors.green,
              lineHeight: 25,
              backgroundColor: Colors.white70,
              curve: Curves.bounceOut,
              percent: progress,
              center: Text(
                '${progress * 100} %',
                style: AppTheme.subheading3,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(courseTitle),
                    Text("$totalDuration"),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: onPressed,
                      child: Text("Learn"),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    width: 150,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
