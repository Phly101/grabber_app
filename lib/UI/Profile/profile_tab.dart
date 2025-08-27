import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import 'package:grabber_app/UI/Profile/widgets/about_app.dart';
import 'package:grabber_app/UI/Profile/widgets/content.dart';
import 'package:grabber_app/UI/Profile/widgets/profile_header.dart';

class ProfileTab extends StatelessWidget {
  static const String routeName = "Profile_tab";
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(
      //   title: const Text("Profile",style: TextStyle(fontWeight: FontWeight.bold),),
      // ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(),
              SizedBox(height: 16),
              ProfileContent(),
              SizedBox(height: 10),
              Text(
                "More",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: LightThemeData.blackColor,
                ),
              ),
              SizedBox(height: 10),
              AboutApp()
            ],
          ),
        ),
      ),
    );
    
  }
}
