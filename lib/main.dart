// import "package:device_preview/device_preview.dart";
// import "package:flutter/foundation.dart";

// Flutter & Firebase
import "package:cloud_firestore/cloud_firestore.dart" show FirebaseFirestore;
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_localizations/flutter_localizations.dart";

import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
import "package:grabber_app/Services/FireStore/firestore_service.dart";

import "package:grabber_app/Services/Users/user_services.dart";

import "Services/Authentication/auth_service.dart";

// App core
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/Utils/constants.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/firebase_options.dart";
import "package:grabber_app/l10n/app_localizations.dart";
import "package:shared_preferences/shared_preferences.dart";

// Blocs
import "package:grabber_app/Services/Users/Bloc/user_bloc.dart" hide User;
import "Blocs/Theming/app_theme_bloc.dart";
import "Blocs/localization/localization.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";

// Features (barrel files or grouped imports)
import "package:grabber_app/UI/ui.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          final userServices = UserServices(snapshot.data!.uid);

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    AuthBloc(authService: AuthService())..add(AppStarted()),
              ),
              BlocProvider(
                create: (_) =>
                    LocaleBloc(FirebaseFirestore.instance)
                      ..add(InitialLangEvent()),
              ),
              BlocProvider(create: (_) => AppThemeBloc()..add(InitialEvent())),
              BlocProvider(
                create: (_) =>
                    UserBloc(userServices: userServices)
                      ..add(const FetchUserData()),
              ),
              BlocProvider(
                create: (_) => CartBloc(userServices)..add(LoadCartEvent()),
              ),
              BlocProvider(create: (_) => ItemsBloc(FirestoreService())),
              //  BlocProvider(create: (_) => VerificationBloc(VerificationService())),
            ],
            child: const MyApp(),
          );
        } else {
          // If no user → only provide AuthBloc, theme, locale
          return MultiBlocProvider(
            providers: [
              // BlocProvider(create: (_) => VerificationBloc(VerificationService())),
              BlocProvider(
                create: (_) =>
                    AuthBloc(authService: AuthService())..add(AppStarted()),
              ),
              BlocProvider(
                create: (_) =>
                    LocaleBloc(FirebaseFirestore.instance)
                      ..add(InitialLangEvent()),
              ),
              BlocProvider(create: (_) => AppThemeBloc()..add(InitialEvent())),
            ],
            child: const MyApp(),
          );
        }
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeBloc, AppThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            String locale = sharedPreferences!.getString("lang") ?? "en";
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
                  GlobalCupertinoLocalizations.delegate,
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
                  AppRoutes.summary: (_) => const SummaryScreen(),
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
    );
  }
}
