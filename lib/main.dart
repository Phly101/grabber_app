import "package:flutter/material.dart";
import "package:grabber_app/Theme/light_theme.dart";
import "package:grabber_app/UI/Payment/payment_screen.dart";
import "package:grabber_app/UI/Profile/profile_tab.dart";
import "package:grabber_app/UI/Schedule/schedule_screen.dart";
import "package:grabber_app/UI/Search/search_tab.dart";
import "package:grabber_app/UI/Settings/settings_tab.dart";
import "package:grabber_app/UI/SplashScreen/splash_screen.dart";
import "package:grabber_app/UI/Summary/summary_screen.dart";
import "package:grabber_app/UI/checkout/checkout_screen.dart";
import "package:grabber_app/UI/home/home_tab.dart";
import "package:grabber_app/UI/main_app/main_screen.dart";

void main() {
  
  runApp(
    MyApp(), 
  );
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
        PaymentScreen.routeName: (context)=> const PaymentScreen(),
        CheckoutScreen.routeName: (context)=>const CheckoutScreen(),
        SummaryScreen.routeName: (context)=> const SummaryScreen(),
        ScheduleScreen.routeName: (context)=> const ScheduleScreen(),
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
