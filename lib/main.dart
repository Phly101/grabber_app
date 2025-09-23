// import "package:device_preview/device_preview.dart";
// import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Blocs/cart%20bloc/cart_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/AboutScreen/about_screen.dart";
import "package:grabber_app/UI/Cart/view/cart_page.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:grabber_app/UI/Payment/payment_screen.dart";
import "package:grabber_app/UI/Profile/profile_tab.dart";
import "package:grabber_app/UI/Schedule/schedule_screen.dart";
import "package:grabber_app/UI/Search/search_tab.dart";
import "package:grabber_app/UI/Settings/drawer/app_drawer.dart";
import "package:grabber_app/UI/Settings/drawer/pages/language_page.dart";
import "package:grabber_app/UI/Settings/drawer/pages/theme_page.dart";
import "package:grabber_app/UI/SplashScreen/splash_screen.dart";
import "package:grabber_app/UI/Summary/summary_screen.dart";
import "package:grabber_app/UI/auth/login.dart";
import "package:grabber_app/UI/auth/sign_up.dart";
import "package:grabber_app/UI/checkout/checkout_screen.dart";
import "package:grabber_app/UI/home/home_tab.dart";
import "package:grabber_app/UI/main_app/main_screen.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:shared_preferences/shared_preferences.dart";
import "Blocs/localization/app_locale_event.dart";
import "Blocs/localization/app_locale_state.dart";
import "Blocs/localization/app_locale_bloc.dart";
import "Utils/constants.dart";
import "package:grabber_app/l10n/app_localizations.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  sharedPref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LocaleBloc()..add(InitialLangEvent()),
        ),
        BlocProvider(
          create: (_) => AppThemeBloc()..add(InitialEvent()),
        ),
        BlocProvider(
          create: (_)=>CartBloc()
          ),
      ],
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, localeState) {
              String locale = sharedPref!.getString("lang") ?? "en";
              if (localeState is ChangeLang) {
                locale = localeState.langCode;
              }

              return AnimatedTheme(
                data: themeState.appTheme == "L"
                    ? AppThemes.lightTheme
                    : AppThemes.darkTheme,
                duration: const Duration(milliseconds: 300),
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: Locale(locale),
                  supportedLocales: const [
                    Locale("en"),
                    Locale("ar"),
                  ],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  localeResolutionCallback: (deviceLocale, supportedLocales) {
                    for (var locale in supportedLocales) {
                      if (deviceLocale != null) {
                        if (deviceLocale.languageCode == locale.languageCode) {
                          return deviceLocale;
                        }
                      }
                    }
                    return supportedLocales.first;
                  },
                  builder: (context, child) {
                    return Directionality(
                      textDirection: locale == "ar"
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: child!,
                    );
                  },

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
                    AppRoutes.summary: (_) => SummaryScreen(),
                    AppRoutes.cart: (_) => const CartPage(),
                    AppRoutes.schedule: (_) => const ScheduleScreen(),
                    AppRoutes.splash: (_) => const SplashScreen(),
                    AppRoutes.language: (_) => const LanguagePage(),
                    AppRoutes.theme: (_) => const ThemePage(),
                    AppRoutes.aboutScreen: (_) => const AboutScreen(),
                  },
                  home: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: themeState.appTheme == "L"
                            ? const AssetImage("Assets/Images/lightSplash.png")
                            : const AssetImage("Assets/Images/darkSplash.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const SplashScreen(),
                  ),
                  themeMode: ThemeMode.system,
                  theme: themeState.appTheme == "L"
                      ? AppThemes.lightTheme
                      : AppThemes.darkTheme,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
