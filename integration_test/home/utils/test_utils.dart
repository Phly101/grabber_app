// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:grabber_app/Blocs/CartBloc/cart_bloc.dart';
// import 'package:grabber_app/Services/FireStore/bloc/items_bloc.dart';
// import 'package:grabber_app/l10n/app_localizations.dart';
//
// // Mock classes
// class MockCartBloc extends Mock implements CartBloc {}
// class MockItemsBloc extends Mock implements ItemsBloc {}
//
// Widget createWidgetForTesting({required Widget child}) {
//   final mockCartBloc = MockCartBloc();
//   final mockItemsBloc = MockItemsBloc();
//
//   // Mock للـ CartBloc
//   when(() => mockCartBloc.state).thenReturn(const CartState());
//   when(() => mockCartBloc.stream).thenAnswer((_) => Stream.fromIterable([const CartState()]));
//   when(() => mockCartBloc.close()).thenAnswer((_) async {});
//
//   // Mock للـ ItemsBloc مع data mock - List<Map<String, dynamic>>
//   final mockItems = [
//     {
//       'id': '1',
//       'title_en': 'Apple',
//       'title_ar': 'تفاح',
//       'image_URL': 'https://example.com/apple.jpg',
//       'price': 5.0,
//     },
//     {
//       'id': '2',
//       'title_en': 'Banana',
//       'title_ar': 'موز',
//       'image_URL': 'https://example.com/banana.jpg',
//       'price': 3.0,
//     },
//     {
//       'id': '3',
//       'title_en': 'Orange',
//       'title_ar': 'برتقال',
//       'image_URL': 'https://example.com/orange.jpg',
//       'price': 4.0,
//     },
//     {
//       'id': '4',
//       'title_en': 'Grape',
//       'title_ar': 'عنب',
//       'image_URL': 'https://example.com/grape.jpg',
//       'price': 6.0,
//     },
//     {
//       'id': '5',
//       'title_en': 'Mango',
//       'title_ar': 'مانجو',
//       'image_URL': 'https://example.com/mango.jpg',
//       'price': 7.0,
//     },
//   ];
//
//   // Mock للـ state و stream و close
//   when(() => mockItemsBloc.state).thenReturn(ItemsLoaded(mockItems));
//   when(() => mockItemsBloc.stream).thenAnswer((_) => Stream.fromIterable([ItemsLoaded(mockItems)]));
//   when(() => mockItemsBloc.close()).thenAnswer((_) async {});
//
//   // إضافة mock للـ add method (عشان يدعم أي event، زي LoadItems لو موجود)
//   when(() => mockItemsBloc.add(any())).thenReturn(null);
//
//   return MultiBlocProvider(
//     providers: [
//       BlocProvider<CartBloc>(create: (_) => mockCartBloc),
//       BlocProvider<ItemsBloc>(create: (_) => mockItemsBloc),
//     ],
//     child: MaterialApp(
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//       supportedLocales: AppLocalizations.supportedLocales,
//       home: child,
//     ),
//   );
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:grabber_app/Blocs/CartBloc/cart_bloc.dart';
// import 'package:grabber_app/Services/FireStore/bloc/items_bloc.dart';
// import 'package:grabber_app/l10n/app_localizations.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:grabber_app/firebase_options.dart';
//
// class MockCartBloc extends Mock implements CartBloc {}
// class MockItemsBloc extends Mock implements ItemsBloc {}
// class FakeItemsEvent extends Fake implements ItemsEvent {}
//
// void registerMockFallbacks() {
//   registerFallbackValue(FakeItemsEvent());
// }
// Future<Widget> createWidgetForTesting({required Widget child}) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {}
//
//   final mockCartBloc = MockCartBloc();
//   final mockItemsBloc = MockItemsBloc();
//
//   when(() => mockCartBloc.state).thenReturn(const CartState());
//   when(() => mockCartBloc.stream).thenAnswer((_) => Stream.fromIterable([const CartState()]));
//   when(() => mockCartBloc.close()).thenAnswer((_) async {});
//
//   final mockItems = [
//     {'id': '1', 'title_en': 'Apple', 'title_ar': 'تفاح', 'image_URL': 'https://example.com/apple.jpg', 'price': 5.0},
//     {'id': '2', 'title_en': 'Banana', 'title_ar': 'موز', 'image_URL': 'https://example.com/banana.jpg', 'price': 3.0},
//     {'id': '3', 'title_en': 'Orange', 'title_ar': 'برتقال', 'image_URL': 'https://example.com/orange.jpg', 'price': 4.0},
//     {'id': '4', 'title_en': 'Grape', 'title_ar': 'عنب', 'image_URL': 'https://example.com/grape.jpg', 'price': 6.0},
//     {'id': '5', 'title_en': 'Mango', 'title_ar': 'مانجو', 'image_URL': 'https://example.com/mango.jpg', 'price': 7.0},
//   ];
//
//   when(() => mockItemsBloc.state).thenReturn(ItemsLoaded(mockItems));
//   when(() => mockItemsBloc.stream).thenAnswer((_) => Stream.fromIterable([ItemsLoaded(mockItems)]));
//   when(() => mockItemsBloc.close()).thenAnswer((_) async {});
//   when(() => mockItemsBloc.add(any())).thenReturn(null);
//
//   return MultiBlocProvider(
//     providers: [
//       BlocProvider<CartBloc>(create: (_) => mockCartBloc),
//       BlocProvider<ItemsBloc>(create: (_) => mockItemsBloc),
//     ],
//     child: MaterialApp(
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//       supportedLocales: AppLocalizations.supportedLocales,
//       home: child,
//     ),
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import 'package:mocktail/mocktail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grabber_app/firebase_options.dart';
import 'package:grabber_app/Blocs/CartBloc/cart_bloc.dart';
import 'package:grabber_app/Services/FireStore/bloc/items_bloc.dart';
import 'package:grabber_app/l10n/app_localizations.dart';

/// ✅ Mock classes
class MockCartBloc extends Mock implements CartBloc {}
class MockItemsBloc extends Mock implements ItemsBloc {}
class FakeItemsEvent extends Fake implements ItemsEvent {}

/// ✅ لتسجيل fallback للقيم اللي بيحتاجها mocktail
void registerMockFallbacks() {
  registerFallbackValue(FakeItemsEvent());
}

/// ✅ دالة لتجهيز الـ app مع mock blocs
Future<Widget> createWidgetForTesting({required Widget child}) async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {
    // ignore error لو firebase مت initialized قبل كده
  }

  final mockCartBloc = MockCartBloc();
  final mockItemsBloc = MockItemsBloc();

  // Mock CartBloc
  when(() => mockCartBloc.state).thenReturn(const CartState());
  when(() => mockCartBloc.stream)
      .thenAnswer((_) => Stream.fromIterable([const CartState()]));
  when(() => mockCartBloc.close()).thenAnswer((_) async {});

  // Mock data للـ ItemsBloc
  final mockItems = [
    {'id': '1', 'title_en': 'Apple', 'title_ar': 'تفاح', 'image_URL': 'https://example.com/apple.jpg', 'price': 5.0},
    {'id': '2', 'title_en': 'Banana', 'title_ar': 'موز', 'image_URL': 'https://example.com/banana.jpg', 'price': 3.0},
    {'id': '3', 'title_en': 'Orange', 'title_ar': 'برتقال', 'image_URL': 'https://example.com/orange.jpg', 'price': 4.0},
    {'id': '4', 'title_en': 'Grape', 'title_ar': 'عنب', 'image_URL': 'https://example.com/grape.jpg', 'price': 6.0},
    {'id': '5', 'title_en': 'Mango', 'title_ar': 'مانجو', 'image_URL': 'https://example.com/mango.jpg', 'price': 7.0},
  ];

  when(() => mockItemsBloc.state).thenReturn(ItemsLoaded(mockItems));
  when(() => mockItemsBloc.stream)
      .thenAnswer((_) => Stream.fromIterable([ItemsLoaded(mockItems)]));
  when(() => mockItemsBloc.close()).thenAnswer((_) async {});
  when(() => mockItemsBloc.add(any())).thenReturn(null);

  return MultiBlocProvider(
    providers: [
      BlocProvider<CartBloc>(create: (_) => mockCartBloc),
      BlocProvider<ItemsBloc>(create: (_) => mockItemsBloc),
      BlocProvider<AppThemeBloc>(
        create: (_) => AppThemeBloc(),
      ),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}
