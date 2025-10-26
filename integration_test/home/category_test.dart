import "package:flutter/cupertino.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:grabber_app/main.dart" as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("tap on category scrolls to its list view", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

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
    expect(categoryFound, true, reason: "Category '$categoryName' not found after waiting. Check Firestore data, UI Material wrapping, or network.");

    final category = find.byKey(categoryKey);
    await tester.ensureVisible(category);   //3lshan ya2dr y3ml scroll
    await tester.tap(category);

    await tester.pumpAndSettle();

    final list = find.byKey(const Key('category_listview'));
    expect(list, findsOneWidget);
  });
}