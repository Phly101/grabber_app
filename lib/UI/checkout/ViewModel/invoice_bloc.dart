import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceAPI/pdf_invocie_api.dart";
import "package:grabber_app/UI/checkout/ViewModel/invoice_event.dart";
import "package:grabber_app/UI/checkout/ViewModel/invoice_state.dart";


class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(InvoiceInitial()) {
    on<GenerateInvoiceEvent>((event, emit) async {
      emit(InvoiceLoading());
      try {
        final pdfFile = await PdfInvoiceApi.generate(event.data);
        emit(InvoiceGenerated(pdfFile));
      } catch (e) {
        emit(InvoiceError("Failed to generate invoice: $e"));
      }
    });
  }
}
