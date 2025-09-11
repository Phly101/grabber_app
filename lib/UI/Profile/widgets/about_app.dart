import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56, 
      decoration: BoxDecoration(
        color: LightThemeData.surfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: ListTile(
                title: const Text("About App"),
                // TODO: Localize "About App" for multi-language support
                leading: ClipOval(
                  child: Container(
                    color: Colors.grey.shade100,
                    padding: const EdgeInsets.all(12),
                    width: 40,
                    height: 40,
                    child: const ImageIcon(
                      AssetImage("Assets/Icons/Heart.png"),
                      color: Colors.red,
                    ),
                    // TODO: Replace static asset with a proper app-related icon
                  ),
                ),
              ),
              onTap: () {
                // TODO: Navigate to About screen with app info, version, developer details
              },
            ),
          ],
        ),
      ),
    );
  }
}
