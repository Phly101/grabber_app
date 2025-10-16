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
    final t = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: CardInputField(
            label: t.expiry,
            controller: expiryController,
            validator: (value) => validateCardExpiry(value ?? ""),
            hintText: "MM/YY",
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CardInputField(
            label: t.cvc,
            controller: cvcController,
            validator: (value) => validateCardCVC(value ?? ""),
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

  String? validateCardExpiry(String input) {
    final s = input.trim();
    final regex = RegExp(r"^(0[1-9]|1[0-2])\s*[/\-]?\s*(\d{2}|\d{4})$");
    final match = regex.firstMatch(s);

    if (match == null) return "Invalid format. Use MM/YY or MM/YYYY.";

    final month = int.parse(match.group(1)!);
    var year = int.parse(match.group(2)!);
    if (match.group(2)!.length == 2) year += 2000;

    final now = DateTime.now();
    final currentYm = now.year * 100 + now.month;
    final cardYm = year * 100 + month;

    if (cardYm < currentYm) return "Card expired.";
    if (cardYm > (now.year + 20) * 100 + now.month) {
      return "Expiry year too far in the future.";
    }

    return null;
  }

  String? validateCardCVC(String input) {
    final cvc = input.trim();
    if (cvc.isEmpty) return "CVC is required.";
    if (!RegExp(r"^[0-9]{3,4}$").hasMatch(cvc)) {
      return "Invalid CVC. Must be 3 or 4 digits.";
    }
    return null;
  }

  bool isExpiryValid(String input) => validateCardExpiry(input) == null;
}


