import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:grabber_app/Services/Authentication/auth_service.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:grabber_app/Services/Verification/Bloc/verification_bloc.dart";
import "package:grabber_app/Services/Verification/verification_service.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Blocs/localization/localization.dart";
import "package:grabber_app/UI/auth/login.dart";
import "package:grabber_app/UI/auth/sign_up.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/firebase_options.dart";
import "package:grabber_app/l10n/app_localizations.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:integration_test/integration_test.dart";

Widget createTestApp() {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthBloc(authService: AuthService())),
      BlocProvider(
        create: (_) => LocaleBloc(FirebaseFirestore.instance)
          ..add(InitialLangEvent()),
      ),
      BlocProvider(create: (_) => AppThemeBloc()..add(InitialEvent())),
      BlocProvider(create: (_) => VerificationBloc(VerificationService())),
    ],
    child: MaterialApp(
      locale: const Locale("en"),
      supportedLocales: const [Locale("en"), Locale("ar")],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: {
        AppRoutes.login: (_) => const Login(),
        AppRoutes.signUp: (_) => const SignUp(),
      },
      home: const Login(),
      theme: AppThemes.lightTheme,
    ),
  );
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  group("Authentication Tests", () {

    testWidgets("Login Test", (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).first, "test@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "12345678");
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });

    testWidgets("Navigate to Sign Up screen", (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.tap(find.byType(TextButton).last);
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(5));

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), "Test User");
      await tester.pumpAndSettle();

      await tester.enterText(fields.at(1), "01123456789");
      await tester.pumpAndSettle();

      await tester.enterText(fields.at(2), "newuser@gmail.com");
      await tester.pumpAndSettle();

      await tester.enterText(fields.at(3), "01234567");
      await tester.pumpAndSettle();

      await tester.enterText(fields.at(4), "01234567");
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Cairo").last);
      await tester.pumpAndSettle();

      final signUpButton = find.byType(ElevatedButton).first;
      await tester.ensureVisible(signUpButton);
      await tester.pumpAndSettle();

      await tester.tap(signUpButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });

    testWidgets("Form validation prevents empty submission", (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final fieldsBeforeSubmit = find.byType(TextFormField);
      final fieldsCountBefore = fieldsBeforeSubmit.evaluate().length;

      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final fieldsAfterSubmit = find.byType(TextFormField);
      final fieldsCountAfter = fieldsAfterSubmit.evaluate().length;

      expect(fieldsCountAfter, fieldsCountBefore);
      expect(find.byType(TextFormField), findsAtLeast(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}