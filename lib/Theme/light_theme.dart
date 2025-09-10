// ignore_for_file: prefer_double_quotes, prefer_const_constructors

import "package:flutter/material.dart";

class LightThemeData {
  static const Color primaryLightColor = Color(0xffEBFFD7);
  static const Color secondaryLightColor = Color(0xffAEDC81);
  static const Color secondaryDarkColor = Color(0xff6CC51D);
  static const Color darkPrimaryColor = Color(0xff0CA201);

  //--------------------------

  static const Color surfaceColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff000000);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    appBarTheme: AppBarTheme(backgroundColor: LightThemeData.primaryLightColor),
    scaffoldBackgroundColor: const Color(0xffffffff),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: LightThemeData.darkPrimaryColor,
      unselectedItemColor: LightThemeData.blackColor,
      backgroundColor: LightThemeData.primaryLightColor,

      selectedLabelStyle: TextStyle(
        color: LightThemeData.blackColor,
        fontSize: 8,
      ),
    ),
    iconTheme: const IconThemeData(color: LightThemeData.blackColor),

    textTheme: const TextTheme(
      titleSmall: TextStyle(color: Colors.grey, fontSize: 14),

      titleMedium: TextStyle(
        color: LightThemeData.blackColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),

      titleLarge: TextStyle(color: LightThemeData.blackColor, fontSize: 22),

      bodySmall: TextStyle(
        color: LightThemeData.darkPrimaryColor,
        fontSize: 14,
      ),
        bodyMedium: TextStyle(
          color: LightThemeData.surfaceColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkPrimaryColor,
      primary: primaryLightColor,

      onPrimary: blackColor,
      secondary: darkPrimaryColor,
      onSecondary: blackColor,
      surface: surfaceColor,
    ),
  );
}
