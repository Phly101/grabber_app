import 'package:flutter/material.dart';
import 'package:grabber_app/UI/checkout/widgets/delivery_option_tile.dart';
import 'package:grabber_app/UI/checkout/widgets/key_switch_tile.dart';
import 'package:grabber_app/UI/checkout/widgets/key_value_tile.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("Checkout"),
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
                border: Border.all(color: Color(0xFFECECEC), width: 2),
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
                  KeyValueTile.icon(
                    leading: Image.asset(
                      "Assets/Icons/icon-park-outline_time.png",
                    ),
                    label: "Schedule",
                    icon: Icons.chevron_right,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            KeyValueTile.icon(
              label: "Order Summary (12 items)",
              icon: Icons.chevron_right,
              color: Colors.black,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFECECEC), width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  KeyValueTile.text(label: "Subtotal", value: "\$40.25"),
                  Divider(height: 1, thickness: 2, color: Color(0xFFECECEC)),
                  KeyValueTile.text(label: "Bag fee", value: "\$0.25"),
                  Divider(height: 1, thickness: 2, color: Color(0xFFECECEC)),
                  KeyValueTile.text(label: "Service fee", value: "\$5.25"),
                  Divider(height: 1, thickness: 2, color: Color(0xFFECECEC)),
                  KeyValueTile.text(label: "Delivery", value: "\$0.00"),
                  Divider(height: 1, thickness: 2, color: Color(0xFFECECEC)),
                  KeyValueTile.text(
                    label: "Total",
                    value: "\$49.00",
                    color: Colors.black,
                  ),
                  Divider(height: 1, thickness: 2, color: Color(0xFFECECEC)),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xFF0CA201)),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
                ),
                child: Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}