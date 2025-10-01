import "dart:io";
import "package:grabber_app/UI/checkout/Model/InvoiceAPI/pdf_api.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/customer_model.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/invoice_data.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/supplier_model.dart";
import "package:grabber_app/Utils/utils.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;

class PdfInvoiceApi {
  static Future<File> generate(InvoiceData invoice) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (_) => [
          buildHeader(invoice),
          pw.SizedBox(height: 20),
          buildTitle(invoice),
          buildInvoice(invoice),
          pw.Divider(),
          buildTotal(invoice),
        ],
        footer: (_) => buildFooter(invoice),
      ),
    );

    return PdfApi.saveDocument(name: "my_invoice.pdf", pdf: pdf);
  }

  /// ---------- HEADER ----------
  static pw.Widget buildHeader(InvoiceData invoice) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          buildSupplierAddress(invoice.supplier!),
          pw.Container(
            height: 50,
            width: 50,
            child: pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data: invoice.info!.number,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          buildCustomerAddress(invoice.customer!),
          buildInvoiceInfo(invoice.info!),
        ],
      ),
    ],
  );

  static pw.Widget buildCustomerAddress(Customer customer) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        customer.name ?? "Customer name",
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
      pw.Text(customer.address ?? "Customer address"),
    ],
  );

  static pw.Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = "${info.dueDate.difference(info.date).inDays} days";
    final titles = <String>[
      "Invoice Number:",
      "Invoice Date:",
      "Payment Terms:",
      "Due Date:",
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      paymentTerms,
      Utils.formatDate(info.dueDate),
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        return buildText(title: titles[index], value: data[index], width: 200);
      }),
    );
  }

  static pw.Widget buildSupplierAddress(Supplier supplier) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        supplier.name ?? "Supplier name",
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 1 * PdfPageFormat.mm),
      pw.Text(supplier.address ?? "Supplier address"),
    ],
  );

  /// ---------- TITLE ----------
  static pw.Widget buildTitle(InvoiceData invoice) => pw.Column(
    children: [
      pw.Text(
        "Invoice",
        style: pw.TextStyle(
          fontSize: 24,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
      pw.Text(invoice.info?.description ?? "Description"),
      pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );

  /// ---------- TABLE ----------
  static pw.Widget buildInvoice(InvoiceData invoice) {
    final headers = [
      "Description",
      "Date",
      "Quantity",
      "Sub total",
      "VAT",
      "Total",
    ];

    final data = invoice.items?.map((item) {
      final subTotal = item.unitPrice * item.quantity;
      final total = subTotal * (1 + item.vat);
      return [
        item.description,
        Utils.formatDate(item.date),
        "${item.quantity}",
        Utils.formatPrice(subTotal),
        "${(item.vat * 100).toStringAsFixed(0)} %",
        Utils.formatPrice(total),
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data ?? [],
      border: null,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
      },
    );
  }

  /// ---------- TOTALS ----------
  static pw.Widget buildTotal(InvoiceData invoice) {
    final netTotal = invoice.items
        ?.map((item) => item.unitPrice * item.quantity)
        .fold(0.0, (a, b) => a + b) ??
        0.0;

    final vat = invoice.items
        ?.map((item) => item.unitPrice * item.quantity * item.vat)
        .fold(0.0, (a, b) => a + b) ??
        0.0;

    final total = netTotal + vat;

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Row(
        children: [
          pw.Spacer(flex: 6),
          pw.Expanded(
            flex: 4,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                buildText(
                  title: "Net total",
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: "VAT",
                  value: Utils.formatPrice(vat),
                  unite: true,
                ),
                pw.Divider(),
                buildText(
                  title: "Total amount due",
                  titleStyle: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total),
                  unite: true,
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
                pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------- HELPERS ----------
  static pw.Widget buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);
    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static pw.Widget buildFooter(InvoiceData invoice) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Divider(),
      pw.SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(
          title: "Address", value: invoice.supplier?.address ?? ""),
      pw.SizedBox(height: 1 * PdfPageFormat.mm),
      buildSimpleText(
        title: "Paypal",
        value: invoice.supplier?.paymentInfo ?? "",
      ),
    ],
  );

  static pw.Widget buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(title, style: style),
        pw.SizedBox(width: 2 * PdfPageFormat.mm),
        pw.Text(value),
      ],
    );
  }
}
