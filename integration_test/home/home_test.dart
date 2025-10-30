import "package:integration_test/integration_test.dart";
import "widgets/category_test.dart" as category_tests;
import "widgets/list_view_test.dart" as  product_list_tests;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  category_tests.main();
  product_list_tests.main();
}
