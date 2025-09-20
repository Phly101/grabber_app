// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Payment/Widget/custom_card.dart";
import "package:grabber_app/UI/Payment/Widget/custom_row.dart";
import "package:grabber_app/UI/Payment/Widget/custom_text_field.dart";
import "package:grabber_app/Utils/routes.dart";
import "../../../../l10n/app_localizations.dart";

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String option = "Pay with card";
  String? currentOption;
  String price = "\$49.00";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    option = AppLocalizations.of(context)!.payWithCard;
    currentOption = option;
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.checkout);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(AppLocalizations.of(context)!.payment, style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
              height: 2,
            ),
            CustomRow(option: option, url: "Assets/Icons/credit-card.png"),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                AppLocalizations.of(context)!.cardNumber,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            CustomTextField(),
            CustomCard(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.textButtonColor,
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.confirmAndPay49,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
