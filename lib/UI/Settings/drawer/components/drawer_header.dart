import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: [LightThemeData.darkPrimaryColor, LightThemeData.secondaryDarkColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 60,),
          SizedBox(height: 10),
          Text(
            "Settings",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
