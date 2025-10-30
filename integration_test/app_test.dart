// integration_test/app_test.dart
import "package:integration_test/integration_test.dart";
import "./payment_screen_test.dart" as payment_tests;

void main() {
  // Ensures the binding is initialized for integration tests
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Call the main function from your test file
  payment_tests.main();
}