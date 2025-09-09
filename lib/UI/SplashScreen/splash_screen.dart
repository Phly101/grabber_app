import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:grabber_app/UI/Payment/payment_screen.dart';
import 'package:grabber_app/UI/main_app/main_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "SplashScreen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Image.asset("Assets/Images/logo2.png", fit: BoxFit.contain),
      nextScreen:  PaymentScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      backgroundColor: Colors.transparent,
      centered: true,

      splashIconSize: MediaQuery.of(context).size.height,
    );
  }
}
