
import "package:integration_test/integration_test.dart";
import "./payment_screen_test.dart" as payment_tests;

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();


  payment_tests.main();
}