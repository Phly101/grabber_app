import "dart:io";

import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/UI/checkout/Bloc/invoice_bloc.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/customer_model.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/invoice_data.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/supplier_model.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceRepository/invoice_repository.dart";
import "package:mocktail/mocktail.dart";

class MockInvoiceRepository extends Mock implements InvoiceRepository {}

class FakeInvoiceData extends Fake implements InvoiceData {}

void main() {
  late MockInvoiceRepository mockRepo;
  late InvoiceBloc bloc;
  late InvoiceData mockData;
  late File mockFile;

  setUpAll(() {
    registerFallbackValue(FakeInvoiceData());
  });

  setUp(() {
    mockRepo = MockInvoiceRepository();
    bloc = InvoiceBloc(mockRepo);
    mockFile = File("test_invoice.pdf");
    mockData = InvoiceData(
      info: InvoiceInfo(
        description: "Test Invoice",
        number: "INV-001",
        date: DateTime(2025, 10, 22),
        dueDate: DateTime(2025, 11, 22),
      ),
      supplier: Supplier(
        name: "Test Supplier",
        address: "123 Supplier St",
        paymentInfo: "paypal@supplier.com",
      ),
      customer: Customer(
        name: "Test Customer",
        address: "456 Customer St",
      ),
      items: [
        InvoiceItem(
          description: "Item 1",
          date: DateTime(2025, 10, 22),
          quantity: 2,
          unitPrice: 50.0,
        ),
      ],
    );
  });

  tearDown(() => bloc.close());

  group("InvoiceBloc", () {
    test("initial state is InvoiceInitial", () {
      expect(bloc.state, isA<InvoiceInitial>());
    });

    blocTest<InvoiceBloc, InvoiceState>(
      "emits [InvoiceLoading, InvoiceGenerated] when repo.generate succeeds",
      build: () {
        when(() => mockRepo.generate(any())).thenAnswer((_) async => mockFile);
        return bloc;
      },
      act: (bloc) => bloc.add(GenerateInvoiceEvent(mockData)),
      expect: () => [
        isA<InvoiceLoading>(),
        isA<InvoiceGenerated>().having((s) => s.file, "file", mockFile),
      ],
    );

    blocTest<InvoiceBloc, InvoiceState>(
      "emits [InvoiceLoading, InvoiceError] when repo.generate throws",
      build: () {
        when(() => mockRepo.generate(any())).thenThrow(Exception("error"));
        return bloc;
      },
      act: (bloc) => bloc.add(GenerateInvoiceEvent(mockData)),
      expect: () => [
        isA<InvoiceLoading>(),
        isA<InvoiceError>().having(
              (s) => s.message,
          "message",
          contains("Failed to generate invoice"),
        ),
      ],
    );
  });
}
