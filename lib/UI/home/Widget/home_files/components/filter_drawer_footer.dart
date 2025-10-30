import 'package:flutter/material.dart';
import 'package:grabber_app/LocalizationHelper/localization_helper.dart';

class AppElevatedButton extends StatelessWidget {
  final String textKey;
  final VoidCallback onPressed;

  const AppElevatedButton({
    super.key,
    required this.textKey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        LocalizationHelper.getString(context, textKey),
      ),
    );
  }
}
