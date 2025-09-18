import "package:flutter/material.dart";
import "package:grabber_app/UI/checkout/widgets/delivery_option_tile.dart";
import "package:grabber_app/UI/checkout/widgets/key_switch_tile.dart";
import "package:grabber_app/UI/checkout/widgets/key_value_tile.dart";
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.cart);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title:  Text(AppLocalizations.of(context)!.checkout,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFECECEC), width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      DeliveryOptionTile(
                        value: "Priority",
                        title: AppLocalizations.of(context)!.priority1020Mins,
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
                        title: AppLocalizations.of(context)!.standard3045Mins,
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
                        "Assets/Icons/icon-park-outline_time.png",color: theme.colorScheme.onPrimary,
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
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.onPrimary)
                      ),
                      child: KeyValueTile.icon(
                        label:AppLocalizations.of(context)!.orderSummary12Items,
                        icon: Icons.chevron_right,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFECECEC), width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  KeyValueTile.text(
                    label: AppLocalizations.of(context)!.subtotal,
                    value: "\$40.25",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeyValueTile.text(
                    label: AppLocalizations.of(context)!.bagFee,
                    value: "\$0.25",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeyValueTile.text(
                    label: AppLocalizations.of(context)!.serviceFee,
                    value: "\$5.25",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeyValueTile.text(
                    label: AppLocalizations.of(context)!.delivery,
                    value: "\$0.00",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeyValueTile.text(
                    label: AppLocalizations.of(context)!.total,
                    value: "\$49.00",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeySwitchTile(
                    label:  AppLocalizations.of(context)!.requestAnInvoice,
                    value: invoice,
                    onChanged: (val) => setState(() => invoice = val),

                  ),
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.paymentMethod,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
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
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(fontSize: 16),
                  ),
                ),
                child:  Text(AppLocalizations.of(context)!.placeOrder,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
