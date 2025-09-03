import 'package:flutter/material.dart';

import '../../Theme/light_theme.dart';

class Components extends StatelessWidget{
  final Widget child;
  final double height;
  const Components({super.key, required this.child, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
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
              SizedBox(height: height),
              Expanded(
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


