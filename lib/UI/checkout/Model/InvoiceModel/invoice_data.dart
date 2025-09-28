import "package:grabber_app/UI/checkout/Model/InvoiceModel/customer_model.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/supplier_model.dart";

class InvoiceData {
  final InvoiceInfo? info;
  final Supplier? supplier;
  final Customer? customer;
  final List<InvoiceItem>? items;

  const InvoiceData({this.info, this.supplier, this.customer, this.items});
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final int quantity;

  final double vat;
  final double unitPrice;

  const InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}
