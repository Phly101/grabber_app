import "package:flutter/material.dart";
import "package:grabber_app/UI/Payment/Widget/card_input_field.dart";
import "../../../l10n/app_localizations.dart";

class CustomCard extends StatelessWidget {
  final TextEditingController expiryController;
  final TextEditingController cvcController;

  const CustomCard({
    super.key,
    required this.expiryController,
    required this.cvcController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: CardInputField(
            label: loc.expiry,
            controller: expiryController,
            validator: (value) => validateCardExpiry(context,value ?? ""),
            hintText: loc.mmYY,
            keyboardType: TextInputType.number,
            key: const Key("expiryDateField"),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CardInputField(
            key: const Key("cvcField"),
            label: loc.cvc,
            controller: cvcController,
            validator: (value) => validateCardCVC(context,value ?? ""),
            hintText: "***",
            keyboardType: TextInputType.number,
            obscureText: true,
            suffixIcon: Image.asset(
              "Assets/Icons/card-shield.png",
              height: 24,
              width: 24,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  String? validateCardExpiry(BuildContext context,String input) {
    final loc =AppLocalizations.of(context)!;
    final s = input.trim();
    final regex = RegExp(r"^(0[1-9]|1[0-2])\s*[/\-]?\s*(\d{2}|\d{4})$");
    final match = regex.firstMatch(s);

    if (match == null) return  loc.invalidExpiryFormat;

    final month = int.parse(match.group(1)!);
    var year = int.parse(match.group(2)!);
    if (match.group(2)!.length == 2) year += 2000;

    final now = DateTime.now();
    final currentYm = now.year * 100 + now.month;
    final cardYm = year * 100 + month;

    if (cardYm < currentYm) return loc.cardExpired;
    if (cardYm > (now.year + 20) * 100 + now.month) {
      return loc.expiryYearTooFar;
    }

    return null;
  }

  String? validateCardCVC(BuildContext context,String input) {
    final cvc = input.trim();
    if (cvc.isEmpty) return AppLocalizations.of(context)!.cvcRequired;
    if (!RegExp(r"^[0-9]{3,4}$").hasMatch(cvc)) {
      return AppLocalizations.of(context)!.invalidCvc;
    }
    return null;
  }

  bool isExpiryValid(BuildContext context,String input) => validateCardExpiry( context ,input) == null;
}


