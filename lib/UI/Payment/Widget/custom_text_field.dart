import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_multi_formatter/flutter_multi_formatter.dart";

class CardNumberField extends StatelessWidget {
  final TextEditingController controller;

  const CardNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: (value) => validateCardNumber(value ?? ""),
        cursorColor: theme.colorScheme.primary,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CreditCardNumberInputFormatter(),
        ],
        decoration: InputDecoration(
          labelText: "Card Number",
          hintText: "xxxx xxxx xxxx xxxx",
          prefixIcon: const Icon(Icons.credit_card_rounded),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("Assets/Icons/masterCard.png", width: 28, height: 28),
              const SizedBox(width: 6),
              Image.asset("Assets/Icons/visa.png", width: 28, height: 28),
              const SizedBox(width: 10),
            ],
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
        ),
      ),
    );
  }

  String? validateCardNumber(String input) {
    final number = input.replaceAll(RegExp(r"\s+"), "");

    if (number.isEmpty) return "Card number is required.";
    if (!RegExp(r"^[0-9]+$").hasMatch(number)) {
      return "Card number must contain only digits.";
    }
    if (number.length < 13 || number.length > 19) {
      return "Invalid card number length.";
    }
    if (!_isVisa(number) && !_isMasterCard(number)) {
      return "Only Visa or MasterCard are accepted.";
    }
    if (!_passesLuhnCheck(number)) {
      return "Invalid card number.";
    }
    return null;
  }

  bool _isVisa(String number) => number.startsWith("4");

  bool _isMasterCard(String number) {
    final prefix = int.tryParse(number.substring(0, 4)) ?? 0;
    final prefix2 = int.tryParse(number.substring(0, 2)) ?? 0;
    return (prefix2 >= 51 && prefix2 <= 55) || (prefix >= 2221 && prefix <= 2720);
  }

  bool _passesLuhnCheck(String number) {
    int sum = 0;
    bool alternate = false;

    for (int i = number.length - 1; i >= 0; i--) {
      int digit = int.parse(number[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }
}
