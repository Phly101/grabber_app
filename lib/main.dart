// import "package:device_preview/device_preview.dart";
// import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
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
import "Blocs/localization/localEvent.dart";
import "Blocs/localization/localState.dart";
import "Blocs/localization/localeBloc.dart";
import "Utils/constants.dart";
import "package:grabber_app/l10n/app_localizations.dart";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String savedLang = sharedpref?.getString("lang") ?? "en";

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LocaleBloc()..add(ChangeLang(Locale(savedLang))),
        ),
        BlocProvider(
          create: (_) => AppThemeBloc()..add(InitialEvent()),
        ),
      ],
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, localeState) {
              Locale currentLocale = const Locale("en");
              if (localeState is LocalInitial) {
                currentLocale = localeState.locale;
              }
              if (localeState is LocaleUpdated) {
                currentLocale = localeState.locale;
              }
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: currentLocale,
                supportedLocales: const [
                  Locale("en"),
                  Locale("ar"),
                ],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                builder: (context, child) {
                  return Directionality(
                    textDirection: currentLocale.languageCode == "ar"
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
                  AppRoutes.summary: (_) => const SummaryScreen(),
                  AppRoutes.cart: (_) => const CartPage(),
                  AppRoutes.schedule: (_) => const ScheduleScreen(),
                  AppRoutes.splash: (_) => const SplashScreen(),
                  AppRoutes.language:(_)=> const LanguagePage(),
                  AppRoutes.theme:(_)=> const ThemePage(),
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

                theme: themeState.appTheme == "L"
                    ? AppThemes.lightTheme
                    : AppThemes.darkTheme,
              );
            },
          );
        },
      ),
    );
  }
}
