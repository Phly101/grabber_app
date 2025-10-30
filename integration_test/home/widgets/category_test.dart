import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Blocs/localization/localization.dart";
import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
import "package:grabber_app/Services/FireStore/firestore_service.dart";
import "package:grabber_app/UI/home/home_tab.dart";
import "package:grabber_app/l10n/app_localizations.dart";
import "package:integration_test/integration_test.dart";
import "../../mocks/mock_user_services.dart";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  late ItemsBloc itemsBloc;
  late CartBloc cartBloc;
  late LocaleBloc localeBloc;
  late AppThemeBloc themeBloc;
  late MockUserServices mockUserServices;

  setUp(() async {
    await Firebase.initializeApp();
    final firestore = FirebaseFirestore.instance;
    mockUserServices = MockUserServices();

    itemsBloc = ItemsBloc(FirestoreService());
    cartBloc = CartBloc(mockUserServices);
    localeBloc = LocaleBloc(firestore);
    themeBloc = AppThemeBloc();

    final collections = [
      "category",
      "Fruits list",
      "egg&milk",
      "Beverages list",
      "Laundry list",
      "vegetables list",
      "Biscuit list",
      "Detergent list",
    ];

    for (final collection in collections) {
      itemsBloc.add(LoadItems(collection));
    }

    localeBloc.add(InitialLangEvent());
  });

  tearDown(() async {
    await itemsBloc.close();
    await cartBloc.close();
    await localeBloc.close();
    await themeBloc.close();
  });

  group("Category - Integration Test", () {
    testWidgets("should find and tap on a category", (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ItemsBloc>.value(value: itemsBloc),
            BlocProvider<CartBloc>.value(value: cartBloc),
            BlocProvider<LocaleBloc>.value(value: localeBloc),
            BlocProvider<AppThemeBloc>.value(value: themeBloc),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: HomeTab()),
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(milliseconds: 800));

      const categoryName = "Detergent";
      final categoryKey = const Key("${categoryName}_category");

      bool categoryFound = false;
      for (int i = 0; i < 30; i++) {
        await tester.pump(const Duration(seconds: 1));
        final category = find.byKey(categoryKey);
        if (category.evaluate().isNotEmpty) {
          categoryFound = true;
          break;
        }
      }

      expect(categoryFound, true,
          reason:
          "Category '$categoryName' not found after waiting. Check Firestore or data loading.");

      final category = find.byKey(categoryKey);
      await tester.ensureVisible(category);
      await tester.tap(category);
      await tester.pumpAndSettle();

      final list = find.byKey(const Key("category_listview"));
      expect(list, findsOneWidget);
    });
  });
}
