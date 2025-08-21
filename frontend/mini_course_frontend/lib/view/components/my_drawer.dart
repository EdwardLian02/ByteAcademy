import 'package:flutter/material.dart';
import 'package:mini_course_frontend/view/theme.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            //Profile info part
            Column(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.black,
                ),
                SizedBox(height: 10),
                Text(
                  "Aung Bo Bo Hein",
                  style: AppTheme.subheading2,
                ),
                Text(
                  "aungbobohein382@gmail.com",
                  style: AppTheme.body,
                ),
              ],
            ),
            SizedBox(height: 20),
            //List tile part
            showListTile(Icons.home, "Home", () {}),
            showListTile(Icons.book, "Enrollments", () {}),
            showListTile(Icons.settings, "Settings", () {}),
          ],
        ),
      ),
    );
  }
}

Widget showListTile(IconData icon, String title, void Function()? onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.black),
    title: Text(title),
    onTap: onTap,
  );
}
