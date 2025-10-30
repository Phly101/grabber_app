

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";

import "package:grabber_app/l10n/app_localizations.dart";
import "package:integration_test/integration_test.dart";
import "package:mocktail/mocktail.dart";

import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Services/Authentication/bloc/auth_bloc.dart";
import "package:grabber_app/Services/sendGift/Bloc/send_gift_bloc.dart";
import "package:grabber_app/UI/Payment/payment_screen.dart";






class MockCartBloc extends Mock implements CartBloc {}
class MockAuthBloc extends Mock implements AuthBloc {}
class MockGiftBloc extends Mock implements GiftBloc {}


late MockGiftBloc mockGiftBloc;
late MockAuthBloc mockAuthBloc;
late MockCartBloc mockCartBloc;



Widget createWidgetForTesting({required Widget child}) {
  mockGiftBloc = MockGiftBloc();
  mockAuthBloc = MockAuthBloc();
  mockCartBloc = MockCartBloc();


  when(() => mockGiftBloc.state).thenReturn(GiftInitial());
  when(() => mockAuthBloc.state).thenReturn(AuthInitial());
  when(() => mockCartBloc.state).thenReturn(const CartState());


  when(() => mockGiftBloc.stream).thenAnswer((_) => Stream.fromIterable([GiftInitial()]));
  when(() => mockAuthBloc.stream).thenAnswer((_) => Stream.fromIterable([AuthInitial()]));
  when(() => mockCartBloc.stream).thenAnswer((_) => Stream.fromIterable([const CartState()]));


  when(() => mockGiftBloc.close()).thenAnswer((_) async {});
  when(() => mockAuthBloc.close()).thenAnswer((_) async {});
  when(() => mockCartBloc.close()).thenAnswer((_) async {});

  return MultiBlocProvider(
    providers: [
      BlocProvider<GiftBloc>(create: (_) => mockGiftBloc),
      BlocProvider<AuthBloc>(create: (_) => mockAuthBloc),
      BlocProvider<CartBloc>(create: (_) => mockCartBloc),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("PaymentScreen Integration Tests", () {


    final confirmButtonFinder = find.byKey(const Key("confirmAndPayButton"));
    final paymentTitleKeyFinder = find.byKey(const Key("paymentScreenTitle"));
    final cardNumberFinder = find.byKey(const Key("cardNumberField"));


    final expiryFinder = find.byKey(const Key("expiryDateField"));
    final cvcFinder = find.byKey(const Key("cvcField"));


    testWidgets("Verify initial screen content and empty form validation", (tester) async {

      await tester.pumpWidget(
        createWidgetForTesting(
          child: const PaymentScreen(),
        ),
      );
      await tester.pumpAndSettle();


      expect(paymentTitleKeyFinder, findsOneWidget, reason: "Payment screen title (by Key) must be present.");
      expect(cardNumberFinder, findsOneWidget, reason: "Card number field (by Key) must be present.");


      await tester.tap(confirmButtonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing, reason: "Confirm dialog should not show on empty fields");
    });


    testWidgets("Verify form validation success and dialog attempt", (tester) async {

      await tester.pumpWidget(
        createWidgetForTesting(
          child: const PaymentScreen(),
        ),
      );
      await tester.pumpAndSettle();



      await tester.enterText(cardNumberFinder, "4242 4242 4242 4242");


      await tester.enterText(expiryFinder, "12/25");
      await tester.enterText(cvcFinder, "123");
      await tester.pumpAndSettle();


      await tester.tap(confirmButtonFinder);


      await tester.pump();

      await tester.pumpAndSettle();


      expect(find.byType(AlertDialog), findsOneWidget, reason: "Confirm dialog should show on valid fields");


      await tester.tap(find.byType(TextButton).last);
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}