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
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        InkWell(
          child: ListTile(
            title: const Text("About App"),
            leading: ClipOval(
              child: Container(
                color: Colors.grey.shade100, 
                padding: const EdgeInsets.all(12), 
                width: 50, 
                height: 50,
                child: const ImageIcon(AssetImage("Assets/Icons/Heart.png"),color: Colors.red ,)
              ),
          ),
          ),
          onTap: () {
            
          },
        )
        ],
      ),
    );
  }
}
