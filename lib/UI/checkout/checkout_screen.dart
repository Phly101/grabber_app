import "package:flutter/material.dart";
import "package:grabber_app/UI/checkout/widgets/delivery_option_tile.dart";
import "package:grabber_app/UI/checkout/widgets/key_switch_tile.dart";
import "package:grabber_app/UI/checkout/widgets/key_value_tile.dart";
import "package:grabber_app/Utils/routes.dart";

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
        title: const Text("Checkout"),
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
                        title: "Priority (10 - 20 mins)",
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
                        title: "Standard (30 - 45 mins)",
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
                      label: "Schedule",
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
                        label: "Order Summary (12 items)",
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
                    label: "Subtotal",
                    value: "\$40.25",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeyValueTile.text(
                    label: "Bag fee",
                    value: "\$0.25",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeyValueTile.text(
                    label: "Service fee",
                    value: "\$5.25",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeyValueTile.text(
                    label: "Delivery",
                    value: "\$0.00",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeyValueTile.text(
                    label: "Total",
                    value: "\$49.00",
                    color: theme.colorScheme.onPrimary,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                    color: Color(0xFFECECEC),
                  ),
                  KeySwitchTile(
                    label: "Request an invoice",
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
                "Payment method",
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
                child: const Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
