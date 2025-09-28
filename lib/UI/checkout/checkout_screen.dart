import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceAPI/pdf_api.dart";
import "package:grabber_app/UI/checkout/ViewModel/invoice_bloc.dart";
import "package:grabber_app/UI/checkout/ViewModel/invoice_state.dart";
import "package:grabber_app/UI/checkout/widgets/checkout_body.dart";
import "package:grabber_app/Utils/routes.dart";
import "../../../l10n/app_localizations.dart";

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? deliveryType = "Standard";
  bool invoice = false;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => InvoiceBloc(),
      child: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (state is InvoiceError) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Error"),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          } else if (state is InvoiceGenerated) {
            PdfApi.openFile(state.file);
          }
        },
        builder: (context, state) => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.cart);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                title: Text(
                  AppLocalizations.of(context)!.checkout,
                ),

                elevation: 0,
                toolbarHeight: 100,
                centerTitle: true,
              ),
              body: const BuildCheckOutBody(),
            ),
            if (state is InvoiceLoading) ...[
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.black,
                ),
              ),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
