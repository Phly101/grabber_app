import "dart:io";
import "../InvoiceAPI/pdf_invocie_api.dart";
import "../InvoiceModel/invoice_data.dart";

class InvoiceRepository {
  Future<File> generate(InvoiceData data) async {
    return await PdfInvoiceApi.generate(data);
  }
}