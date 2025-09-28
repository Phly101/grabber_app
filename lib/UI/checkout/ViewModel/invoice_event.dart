
import "package:equatable/equatable.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/invoice_data.dart";


sealed class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object?> get props => [];
}

class GenerateInvoiceEvent extends InvoiceEvent {
  final InvoiceData data;

  const GenerateInvoiceEvent(this.data);

  @override
  List<Object?> get props => [data];
}