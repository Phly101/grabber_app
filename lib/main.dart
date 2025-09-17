// import "package:device_preview/device_preview.dart";
// import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Cart/view/cart_page.dart";
import "package:grabber_app/UI/Payment/payment_screen.dart";
import "package:grabber_app/UI/Profile/profile_tab.dart";
import "package:grabber_app/UI/Schedule/schedule_screen.dart";
import "package:grabber_app/UI/Search/search_tab.dart";
import "package:grabber_app/UI/Settings/drawer/app_drawer.dart";
import "package:grabber_app/UI/SplashScreen/splash_screen.dart";
import "package:grabber_app/UI/Summary/summary_screen.dart";
import "package:grabber_app/UI/auth/login.dart";
import "package:grabber_app/UI/auth/sign_up.dart";
import "package:grabber_app/UI/checkout/checkout_screen.dart";
import "package:grabber_app/UI/home/home_tab.dart";
import "package:grabber_app/UI/main_app/main_screen.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:shared_preferences/shared_preferences.dart";

import "Utils/constants.dart";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppThemeBloc()..add(InitialEvent()),
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              AppRoutes.mainApp: (_) => const MainScreen(),
              AppRoutes.login: (_) => const Login(),
              AppRoutes.signUp: (_) => const SignUp(),
              AppRoutes.home: (_) => const HomeTab(),
              AppRoutes.search: (_) => const SearchTab(),
              AppRoutes.profile: (_) => const ProfileTab(),
              AppRoutes.settings: (_) => const AppDrawer(),
              AppRoutes.payment: (_) => const PaymentScreen(),
              AppRoutes.checkout: (_) => const CheckoutScreen(),
              AppRoutes.summary: (_) => const SummaryScreen(),
              AppRoutes.cart: (_) => const CartPage(),
              AppRoutes.schedule: (_) => const ScheduleScreen(),
              AppRoutes.splash: (_) => const SplashScreen(),
            },
            home: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: state.appTheme == "L"
                      ? const AssetImage("Assets/Images/lightSplash.png")
                      : const AssetImage("Assets/Images/darkSplash.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const SplashScreen(),
            ),

            theme: state.appTheme == "L"
                ? AppThemes.lightTheme
                : AppThemes.darkTheme,
          );
        },
      ),
    );
  }
}
