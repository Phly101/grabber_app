import "package:flutter/material.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/Theme/theme.dart";

class FilterDrawerHeader extends StatelessWidget {
  final String titleKey;
  final IconData icon;

  const FilterDrawerHeader({
    super.key,
    this.titleKey = "filter_products",
    this.icon = Icons.filter_list,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DrawerHeader(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryGreen,
            AppColors.secondaryDarkColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
            color: theme.colorScheme.onPrimary,
          ),
          const SizedBox(height: 10),
          Text(
            LocalizationHelper.getString(context, titleKey),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
