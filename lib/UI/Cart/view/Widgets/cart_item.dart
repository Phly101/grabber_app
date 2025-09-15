import "package:flutter/material.dart";
import "package:grabber_app/Theme/light_theme.dart";
import "../../../../l10n/app_localizations.dart";
import "shimmer_image.dart";

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: LightThemeData.primaryLightColor,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const ShimmerImage(size: 50),
        // TODO: Replace static shimmer with product image from network or local cache
        title:  Text(
            AppLocalizations.of(context)!.bananaBundle300g,
          // TODO: Make product name dynamic from cart model
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "\$3.45",
              // TODO: Replace hardcoded price with value from cart item model
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: LightThemeData.surfaceColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const ImageIcon(
                          AssetImage("Assets/Icons/trash-2.png"),
                        ),
                        onPressed: () {
                          // TODO: Implement remove item from cart functionality
                        },
                      ),
                      const Text("1"),
                      // TODO: Bind quantity dynamically from cart item model
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          // TODO: Implement increase quantity functionality
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
