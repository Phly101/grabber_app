import "dart:io";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceAPI/pdf_invocie_api.dart";

import "../Model/InvoiceModel/invoice_data.dart";
import "../Model/InvoiceRepository/invoice_repository.dart";
part "invoice_event.dart";
part "invoice_state.dart";


class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InvoiceRepository repo;

  InvoiceBloc(this.repo) : super(InvoiceInitial()) {
    on<GenerateInvoiceEvent>((event, emit) async {
      emit(InvoiceLoading());
      try {
        final pdfFile = await repo.generate(event.data);
        emit(InvoiceGenerated(pdfFile));
      } catch (e) {
        emit(InvoiceError("Failed to generate invoice: $e"));
      }
    });
  }
}
