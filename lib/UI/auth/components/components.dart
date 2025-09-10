import 'package:flutter/material.dart';

import '../../../Theme/light_theme.dart';

class Components extends StatelessWidget{
  const Components({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            LightThemeData.primaryLightColor,
            LightThemeData.secondaryLightColor,
            LightThemeData.secondaryDarkColor,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text("Grabber", style: TextStyle(color: LightThemeData.darkPrimaryColor, fontWeight: FontWeight.bold, fontSize: 50),),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


