import "package:flutter/material.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/home/product_details/widgets/imports.dart";

class ProductInfo extends StatelessWidget {
  final Map<String, dynamic> product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const ProductInfo({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkSurface : const Color(0xFFF5F5F5);
    final textColor = theme.colorScheme.onSurface;
    final subtitleColor = isDark ? AppColors.darkMediumGrey : Colors.grey[750] ?? Colors.grey;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withAlpha(30)
                : Colors.grey.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizationHelper.localizedProductField(product, "title", context),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),

          PriceAndQuantity(
            product: product,
            quantity: quantity,
            onQuantityChanged: onQuantityChanged,
            subtitleColor: subtitleColor,
            backgroundColor: theme.colorScheme.surface,
            textColor: textColor,
          ),
          const SizedBox(height: 5),

          ProductDescription(
            product: product,
            textColor: textColor,
            subtitleColor: subtitleColor,
          ),
          const SizedBox(height: 15),

          OtherProducts(
            currentProductId: product["id"] ?? "",
            textColor: textColor,
            subtitleColor: subtitleColor,
          ),
          const SizedBox(height: 24),

          AddToCartButton(product: product, quantity: quantity),
        ],
      ),
    );
  }
}