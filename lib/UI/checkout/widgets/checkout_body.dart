import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/customer_model.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/invoice_data.dart";
import "package:grabber_app/UI/checkout/Model/InvoiceModel/supplier_model.dart";

// import "package:grabber_app/UI/checkout/ViewModel/invoice_bloc.dart";
// import "package:grabber_app/UI/checkout/ViewModel/invoice_event.dart";

import "package:grabber_app/UI/checkout/widgets/delivery_option_tile.dart";
import "package:grabber_app/UI/checkout/widgets/key_switch_tile.dart";
import "package:grabber_app/UI/checkout/widgets/key_value_tile.dart";
import "package:grabber_app/UI/checkout/widgets/Delivery/delivery.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/l10n/app_localizations.dart";

import "../Bloc/invoice_bloc.dart";

class BuildCheckOutBody extends StatefulWidget {
  const BuildCheckOutBody({super.key});

  @override
  State<BuildCheckOutBody> createState() => _BuildCheckOutBodyState();
}

class _BuildCheckOutBodyState extends State<BuildCheckOutBody> {
  String? deliveryType = "Standard";
  bool invoice = false;
  final num bagFee = 0.25;

  final num serviceFee = 3.45;

  final num delivery = 5.00;
  final num vat = 0.01;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DeliveryAndPayment(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFECECEC),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      DeliveryOptionTile(
                        value: "Priority",
                        title: AppLocalizations.of(
                          context,
                        )!.priority1020Mins,
                        icon: "Assets/Icons/carbon_receipt.png",
                        groupValue: deliveryType,
                        onChanged: (val) => setState(() => deliveryType = val),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 2,
                        color: Color(0xFFECECEC),
                      ),
                      DeliveryOptionTile(
                        value: "Standard",
                        title: AppLocalizations.of(
                          context,
                        )!.standard3045Mins,
                        icon: "Assets/Icons/fluent_receipt-28-regular.png",
                        groupValue: deliveryType,
                        onChanged: (val) => setState(() => deliveryType = val),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.schedule);
                    },
                    child: KeyValueTile.icon(
                      leading: Image.asset(
                        "Assets/Icons/icon-park-outline_time.png",
                        color: theme.colorScheme.onPrimary,
                      ),
                      label: AppLocalizations.of(context)!.schedule,
                      icon: Icons.chevron_right,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.summary);
                    },
                    child: KeyValueTile.icon(
                      label: AppLocalizations.of(
                        context,
                      )!.orderSummary12Items,
                      icon: Icons.chevron_right,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final num total = state.totalPrice;
                final num finalTotal = total + bagFee + delivery + serviceFee;
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFECECEC),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      KeyValueTile.text(
                        label: AppLocalizations.of(context)!.subtotal,
                        value: "\$${total.toStringAsFixed(2)}",
                        color: theme.colorScheme.onPrimary,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 2,
                        color: Color(0xFFECECEC),
                      ),
                      KeyValueTile.text(
                        label: AppLocalizations.of(context)!.bagFee,
                        value: "\$${bagFee.toString()}",
                        color: theme.colorScheme.onPrimary,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 2,
                        color: Color(0xFFECECEC),
                      ),
                      KeyValueTile.text(
                        label: AppLocalizations.of(context)!.serviceFee,
                        value: "\$${serviceFee.toString()}",
                        color: theme.colorScheme.onPrimary,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 2,
                        color: Color(0xFFECECEC),
                      ),
                      KeyValueTile.text(
                        label: AppLocalizations.of(context)!.delivery,
                        value: "\$${delivery.toString()}",
                        color: theme.colorScheme.onPrimary,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 2,
                        color: Color(0xFFECECEC),
                      ),
                      KeyValueTile.text(
                        label: AppLocalizations.of(context)!.total,
                        value: "\$$finalTotal",
                        color: theme.colorScheme.onPrimary,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 2,
                        color: Color(0xFFECECEC),
                      ),
                      KeySwitchTile(
                        label: AppLocalizations.of(
                          context,
                        )!.requestAnInvoice,
                        value: invoice,
                        onChanged: (val) {
                          setState(() => invoice = val);
                          if (val) {
                            final invoiceData = InvoiceData(
                              info: InvoiceInfo(
                                description: "Grocery order",
                                number: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                date: DateTime.now(),
                                dueDate: DateTime.now().add(
                                  const Duration(days: 7),
                                ),
                              ),
                              supplier: Supplier(
                                name: "Grabber Supermarket",
                                address: "123 Market Street",
                                paymentInfo: "Bank XYZ, IBAN 123456789",
                              ),
                              customer: Customer(
                                name: "Basel Rafei",
                                address: "Cairo, Egypt",
                              ),
                              items: [
                                InvoiceItem(
                                  description: "Service fee",
                                  date: DateTime.now(),
                                  quantity: 1,

                                  unitPrice: serviceFee as double,
                                ),
                                InvoiceItem(
                                  description: "Bag fee",
                                  date: DateTime.now(),
                                  quantity: 1,

                                  unitPrice: bagFee as double,
                                ),
                                InvoiceItem(
                                  description: "Delivery",
                                  date: DateTime.now(),
                                  quantity: 1,

                                  unitPrice: delivery as double,
                                ),
                                InvoiceItem(
                                  description: "Sub total",
                                  date: DateTime.now(),
                                  quantity: 1,

                                  unitPrice: total as double,
                                ),
                                InvoiceItem(
                                  description: "Total",
                                  date: DateTime.now(),
                                  quantity: 1,

                                  unitPrice: finalTotal as double,
                                ),
                              ],
                            );

                            context.read<InvoiceBloc>().add(
                              GenerateInvoiceEvent(invoiceData),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.payment);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xFF0CA201),
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    Colors.white,
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(fontSize: 16),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.placeOrder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
