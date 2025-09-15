import "package:device_preview/device_preview.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_localizations/flutter_localizations.dart";
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
import "package:shared_preferences/shared_preferences.dart";
import "Blocs/LocaleBloc/localeBloc.dart";
import "Blocs/LocaleBloc/localeEvent.dart";
import "Blocs/LocaleBloc/localeState.dart";
import "l10n/app_localizations.dart";

SharedPreferences? sharedpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String savedLang = sharedpref?.getString("lang") ?? "en";
    return BlocProvider(
      create: (_) => LocaleBloc()..add(ChangeLang(Locale(savedLang))),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          Locale currentLocale = const Locale("en");
          if (state is LocalInitial) currentLocale = state.locale;
          if (state is LocaleUpdated) currentLocale = state.locale;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: currentLocale,
            supportedLocales: const [
              Locale("en"),
              Locale("ar"),
            ],
            localizationsDelegates: const [
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
              MainScreen.routeName: (context) => const MainScreen(),
              HomeTab.routeName: (context) => const HomeTab(),
              SearchTab.routeName: (context) => const SearchTab(),
              ProfileTab.routeName: (context) => const ProfileTab(),
              SettingsTab.routeName: (context) => const SettingsTab(),
              PaymentScreen.routeName: (context) => const PaymentScreen(),
              CheckoutScreen.routeName: (context) => const CheckoutScreen(),
              SummaryScreen.routeName: (context) => const SummaryScreen(),
              ScheduleScreen.routeName: (context) => const ScheduleScreen(),
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
        },
      ),
    );
  }
}
