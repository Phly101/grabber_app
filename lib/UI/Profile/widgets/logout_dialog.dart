import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

class LogoutDialog extends StatelessWidget {
 

  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 212,
        height: 150,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              LightThemeData.primaryLightColor,
              LightThemeData.secondaryLightColor,
              LightThemeData.secondaryDarkColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          
            const SizedBox(height: 12),
            const Text(
              "Are you sure you want to log out?",
              textAlign: TextAlign.center,
              style: TextStyle(color: LightThemeData.blackColor,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEA6C6C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Yes"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD500),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  
                  },
                  child: const Text("No"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
