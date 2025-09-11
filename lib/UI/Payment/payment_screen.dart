// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:grabber_app/Theme/light_theme.dart";
import "package:grabber_app/UI/Payment/Widget/custom_card.dart";
import "package:grabber_app/UI/Payment/Widget/custom_row.dart";
import "package:grabber_app/UI/Payment/Widget/custom_text_field.dart";
import "package:grabber_app/UI/checkout/checkout_screen.dart";


class PaymentScreen extends StatefulWidget {
  static String routeName = "PaymentScreen";

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String option = "Pay with card";
  String? currentOption;
  String price = "\$49.00";

  @override
  void initState() {
    super.initState();
    currentOption = option;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        shadowColor: Colors.transparent,
        backgroundColor: LightThemeData.surfaceColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, CheckoutScreen.routeName);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("Payment", style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: LightThemeData.blackColor.withValues(alpha: 0.5),
              height: 2,
            ),
            CustomRow(option: option, url: "Assets/Icons/credit-card.png"),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Card number",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            CustomTextField(),
            CustomCard(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,

                ),
                child: Center(child: Text("Confirm and Pay ($price)",style: Theme.of(context).textTheme.bodyMedium,)),

              ),
            )
          ],
        ),
      ),
    );
  }
}
