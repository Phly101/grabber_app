import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
import "package:grabber_app/UI/Search/search_tab.dart";
import "package:grabber_app/l10n/app_localizations.dart";
import "package:grabber_app/Blocs/localization/localization.dart";
import "package:integration_test/integration_test.dart";
import "package:bloc_test/bloc_test.dart";

class MockItemsBloc extends MockBloc<ItemsEvent, ItemsState> implements ItemsBloc {}
class MockLocaleBloc extends MockBloc<LocaleEvent, LocaleState> implements LocaleBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockItemsBloc mockItemsBloc;
  late MockLocaleBloc mockLocaleBloc;

  setUp(() {
    mockItemsBloc = MockItemsBloc();
    whenListen(
      mockItemsBloc,
      Stream.fromIterable([
        const ItemsLoaded([
          {
            "id": "1",
            "title_en": "Tomatoes",
            "title_ar": "طماطم",
            "image_URL": "https://images-na.ssl-images-amazon.com/images/I/71DYmqoq-VL._SL1024_.jpg",
            "price": 21.2,
          },
          {
            "id": "2",
            "title_en": "Apples",
            "title_ar": "تفاح",
            "image_URL": "https://images.freeimages.com/images/large-previews/e93/apple-1524168.jpg",
            "price": 5.9,
          },
        ]),
      ]),
      initialState: const ItemsLoaded([
        {
          "id": "1",
          "title_en": "Tomatoes",
          "title_ar": "طماطم",
          "image_URL": "https://images-na.ssl-images-amazon.com/images/I/71DYmqoq-VL._SL1024_.jpg",
          "price": 21.2,
        },
        {
          "id": "2",
          "title_en": "Apples",
          "title_ar": "تفاح",
          "image_URL": "https://images.freeimages.com/images/large-previews/e93/apple-1524168.jpg",
          "price": 5.9,
        },
      ]),
    );

    mockLocaleBloc = MockLocaleBloc();
    whenListen(
      mockLocaleBloc,
      Stream.fromIterable([
        ChangeLang(langCode: "en", translations: {}),
      ]),
      initialState: ChangeLang(langCode: "en", translations: {}),
    );
  });

  testWidgets("Entering text in search bar filters products", (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ItemsBloc>.value(value: mockItemsBloc),
          BlocProvider<LocaleBloc>.value(value: mockLocaleBloc),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchTab(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final searchBar = find.byKey(const Key("searchText"));
    expect(searchBar, findsOneWidget);

    await tester.enterText(searchBar, "tomatoes");
    await tester.pumpAndSettle();

    expect(find.text("Tomatoes"), findsOneWidget);

    expect(find.text("Apples"), findsNothing);
  });

  testWidgets("Clearing search text shows all products", (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ItemsBloc>.value(value: mockItemsBloc),
          BlocProvider<LocaleBloc>.value(value: mockLocaleBloc),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchTab(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final searchBar = find.byKey(const Key("searchText"));

    await tester.enterText(searchBar, "tomatoes");
    await tester.pumpAndSettle();

    expect(find.text("Tomatoes"), findsOneWidget);
    expect(find.text("Apples"), findsNothing);

    await tester.enterText(searchBar, "");
    await tester.pumpAndSettle();

    expect(find.text("Tomatoes"), findsOneWidget);
    expect(find.text("Apples"), findsOneWidget);
  });

  testWidgets("Shows no suggestions when search has no matches", (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ItemsBloc>.value(value: mockItemsBloc),
          BlocProvider<LocaleBloc>.value(value: mockLocaleBloc),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SearchTab(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final searchBar = find.byKey(const Key("searchText"));

    await tester.enterText(searchBar, "xyz");
    await tester.pumpAndSettle();

    expect(find.text("Tomatoes"), findsNothing);
    expect(find.text("Apples"), findsNothing);
  });
}