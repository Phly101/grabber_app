import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import 'package:grabber_app/UI/Payment/payment_screen.dart';
import 'package:grabber_app/UI/Profile/profile_tab.dart';
import 'package:grabber_app/UI/Search/search_tab.dart';
import 'package:grabber_app/UI/Settings/settings_tab.dart';
import 'package:grabber_app/UI/SplashScreen/splash_screen.dart';
import 'package:grabber_app/UI/home/home_tab.dart';
import 'package:grabber_app/UI/main_app/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        HomeTab.routeName: (context) => const HomeTab(),
        SearchTab.routeName: (context) => const SearchTab(),
        ProfileTab.routeName: (context) => const ProfileTab(),
        SettingsTab.routeName: (context) => const SettingsTab(),
        PaymentScreen.routName: (context)=> const PaymentScreen(),
      },
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/Images/light splash.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: const SplashScreen(),
      ),


       theme: LightThemeData.lightTheme,
    );
  }
}
