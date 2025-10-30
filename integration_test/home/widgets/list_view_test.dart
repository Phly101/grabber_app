import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grabber_app/Blocs/CartBloc/cart_bloc.dart';
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import 'package:grabber_app/Blocs/localization/localization.dart';
import 'package:grabber_app/Services/FireStore/bloc/items_bloc.dart';
import 'package:grabber_app/Services/FireStore/firestore_service.dart';
import 'package:grabber_app/UI/home/home_tab.dart';
import 'package:grabber_app/l10n/app_localizations.dart';
import 'package:integration_test/integration_test.dart';
import '../../mocks/mock_user_services.dart';

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
    final firestore = FirebaseFirestore.instance;
    mockUserServices = MockUserServices();

    itemsBloc = ItemsBloc(FirestoreService());
    cartBloc = CartBloc(mockUserServices);
    localeBloc = LocaleBloc(firestore);
    themeBloc = AppThemeBloc();

    final collections = [
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

  group("ProductListView - Integration Tests", () {
    testWidgets(
      "should load products, scroll horizontally, and add item to cart",
      (WidgetTester tester) async {
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
        await tester.pump(const Duration(seconds: 2));
        await tester.pump(const Duration(seconds: 2));
        final firstListView = find.byKey(const Key("product_listview")).first;
        expect(firstListView, findsOneWidget);
        final addButtons = find.descendant(
          of: firstListView,
          matching: find.byKey(const Key("add_icon")),
        );
        expect(addButtons, findsAtLeastNWidgets(1));
        await tester.drag(firstListView, const Offset(-400, 0));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.drag(firstListView, const Offset(400, 0));
        await tester.pump(const Duration(milliseconds: 500));
        final firstAddButton = addButtons.first;
        await tester.tap(firstAddButton);
        await tester.pump(const Duration(seconds: 2));
      },
    );
  });
}
