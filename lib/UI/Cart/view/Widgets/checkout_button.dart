import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";
import "../../../../l10n/app_localizations.dart";

class CheckoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CheckoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,  
      height: 60,  
      child: FloatingActionButton.extended(
        onPressed: onPressed, 
        // TODO: Replace with navigation to checkout screen or API call
        backgroundColor: AppColors.textButtonColor,
        // TODO: Add theme switch (light/dark mode) support for dynamic colors
        label:  Text(
            AppLocalizations.of(context)!.checkOut,
          // TODO: Localize this text for multi-language support
          style: const TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold, 
            color: AppColors.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), 
        ),
      ),
    );
  }
}
