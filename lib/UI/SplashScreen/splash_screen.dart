import "package:animated_splash_screen/animated_splash_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:grabber_app/UI/auth/login.dart";
import "package:grabber_app/UI/main_app/main_screen.dart";
import "package:page_transition/page_transition.dart";



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<AppThemeBloc>();
    final authBloc = context.read<AuthBloc>();


    authBloc.add(AppStarted());
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (context, state) {

        Widget nextScreen = const Login();
        if (state is AuthAuthenticated) {
          nextScreen = const MainScreen();
        } else if (state is AuthUnauthenticated || state is AuthInitial) {
          nextScreen = const Login();
        }
        return AnimatedSplashScreen(
          duration: 3000,
          splash: (themeBloc.state.appTheme == "L")
              ? Image.asset("Assets/Images/logo2.png", fit: BoxFit.contain)
              : Image.asset("Assets/Images/logoDark.png", fit: BoxFit.contain),

          nextScreen: nextScreen,

          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.leftToRight,
          backgroundColor: Colors.transparent,
          centered: true,

          splashIconSize: MediaQuery
              .of(context)
              .size
              .height,
        );
      },
    );
  }
}
