import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../../../../Theme/theme.dart";

class TextfieldDelivaryaddress extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  const TextfieldDelivaryaddress({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: AppColors.primaryGreen,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: AppColors.primaryGreen,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: AppColors.primaryGreen,
            width: 1.5,
          ),
        ),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
