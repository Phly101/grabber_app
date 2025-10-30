import "package:flutter/material.dart";
import "../../../../LocalizationHelper/localization_helper.dart";
import "../../../../l10n/app_localizations.dart";

class ProductDescription extends StatelessWidget {
  final Map<String, dynamic> product;
  final Color textColor;
  final Color subtitleColor;

  const ProductDescription({
    super.key,
    required this.product,
    required this.textColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    if (loc == null) return const SizedBox.shrink();

    final description = LocalizationHelper.localizedProductField(
      product,
      "description",
      context,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.description,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description.isNotEmpty
              ? description
              : loc.aReliableHighQualityProductDesignedToMakeEverydayLifeEasierAndBetterPerfectForDailyUseWithGreatValueAndFreshness,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: subtitleColor,
          ),
        ),
      ],
    );
  }
}
