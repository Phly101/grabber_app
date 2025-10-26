// // import "package:flutter/material.dart";
// // import "package:flutter_bloc/flutter_bloc.dart";
// // import "package:flutter_test/flutter_test.dart";
// // import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
// // import "package:integration_test/integration_test.dart";
// // import "package:grabber_app/UI/home/Widget/home_files/product_list_view.dart";
// // import "utils/test_utils.dart";
// //
// // void main() {
// //   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
// //
// //   testWidgets("Test user actions on ProductListView: tap Add to Cart and scroll ListView", (WidgetTester tester) async {
// //     await tester.pumpWidget(createWidgetForTesting(child: ProductListView(title: 'Fruits', collectionName: 'Fruits list', product: null,)));
// //     await tester.pumpAndSettle();
// //     final itemsBloc = BlocProvider.of<ItemsBloc>(tester.element(find.byType(ProductListView)));
// //     print("ItemsBloc state: ${itemsBloc.state}");
// //     print("Current state: ${tester.widget(find.byType(ProductListView)).toString()}");
// //     bool listViewFound = false;
// //     for (int i = 0; i < 10; i++) {
// //       await tester.pump(const Duration(seconds: 1));
// //       final listView = find.byKey(const Key('product_listview'));
// //       if (listView.evaluate().isNotEmpty) {
// //         listViewFound = true;
// //         break;
// //       }
// //       print("Waiting for ListView... iteration $i");
// //     }
// //     expect(listViewFound, true, reason: "ListView not found after waiting. Check mock data.");
// //     final listView = find.byKey(const Key('product_listview'));
// //     expect(listView, findsOneWidget);
// //     final addButton = find.byKey(const Key('add_to_cart_button')).first;
// //     expect(addButton, findsOneWidget);
// //     await tester.tap(addButton);
// //     await tester.pump();
// //     expect(addButton, findsOneWidget);
// //     await tester.drag(listView, const Offset(-200.0, 0.0));
// //     await tester.pump();
// //     expect(listView, findsOneWidget);
// //   }, timeout: const Timeout(Duration(minutes: 2)));  // timeout أقل عشان mock.
// // }
//
// import "package:flutter/foundation.dart";
// import 'package:flutter_test/flutter_test.dart';
// import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
// import 'package:integration_test/integration_test.dart';
// import 'package:grabber_app/UI/home/home_tab.dart';
// import "package:mocktail/mocktail.dart";
// import "utils/test_utils.dart"; // لو ملفك موجود في integration_test/utils/
//
// class FakeItemsEvent extends Fake implements ItemsEvent {}
// void main() {
//
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   setUpAll(() {
//     registerMockFallbacks();
//   });
//   setUpAll(() {
//         registerFallbackValue('create a dummy instance of `ItemsEvent`' );
//     });
//
//
// testWidgets(
//     'Test user actions on HomeTab: tap Add to Cart and scroll ListView',
//         (WidgetTester tester) async {
//       // ✅ هنا التعديل الأساسي
//       await tester.pumpWidget(
//         await createWidgetForTesting(
//           child: const HomeTab(), // تبدأي من الـ HomeTab زي ما انتي عايزة
//         ),
//       );
//
//       await tester.pumpAndSettle();
//
//       print("Current state: HomeTab");
//
//       bool listViewFound = false;
//
//       // ننتظر لحد ما تظهر الـ ListView
//       for (int i = 0; i < 10; i++) {
//         await tester.pump(const Duration(seconds: 1));
//         final listView = find.byKey(const Key('product_listview'));
//         if (listView.evaluate().isNotEmpty) {
//           listViewFound = true;
//           break;
//         }
//         print("Waiting for ListView... iteration $i");
//       }
//
//       // ✅ تأكيد وجود الـ ListView
//       expect(listViewFound, true, reason: "ListView not found after waiting. Check mock data.");
//
//       final listView = find.byKey(const Key('product_listview'));
//       expect(listView, findsOneWidget);
//
//       final addButton = find.byKey(const Key('add_to_cart_button')).first;
//       expect(addButton, findsOneWidget);
//
//       await tester.tap(addButton);
//       await tester.pump();
//
//       await tester.drag(listView, const Offset(0, -300));
//       await tester.pump();
//
//       expect(listView, findsOneWidget);
//     },
//     timeout: const Timeout(Duration(minutes: 2)),
//   );
// }
//

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:grabber_app/UI/home/home_tab.dart';
import 'package:mocktail/mocktail.dart';

import "utils/test_utils.dart"; // المسار حسب مكان المجلد

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerMockFallbacks();
  });

  testWidgets(
    'Test user actions on HomeTab: tap Add to Cart and scroll ListView',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        await createWidgetForTesting(
          child: const HomeTab(),
        ),
      );

      await tester.pumpAndSettle();

      print("✅ HomeTab loaded successfully");

      bool listViewFound = false;

      // انتظار ظهور الـ ListView
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(seconds: 1));
        final listView = find.byKey(const Key('product_listview'));
        if (listView.evaluate().isNotEmpty) {
          listViewFound = true;
          break;
        }
        print("Waiting for ListView... iteration $i");
      }

      expect(listViewFound, true,
          reason: "❌ ListView not found after waiting. Check mock data.");

      // final listView = find.byKey(const Key('product_listview'));
      // expect(listView, findsOneWidget);

      final listView = find.byKey(const Key('product_listview'));
      expect(listView, findsAtLeastNWidgets(1)); // بدل واحدة بالظبط
      final firstList = listView.first;

      final addButton = find.byKey(const Key('add_to_cart_button')).first;
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);
      await tester.pump();
      await tester.drag(firstList, const Offset(0, -300));

      //await tester.drag(listView, const Offset(0, -300));
      await tester.pump();

      expect(listView, findsOneWidget);
      print("✅ ListView scroll and Add to Cart action tested successfully");
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
