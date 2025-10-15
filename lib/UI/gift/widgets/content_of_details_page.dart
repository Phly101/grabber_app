import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";

class ContentOfDetailsPage extends StatelessWidget {
  const ContentOfDetailsPage({
    super.key,
    required this.imageUrl,
    required this.itemName,
    required this.itemQuantity,
    required this.itemPrice,
  });

  final String? imageUrl;
  final String itemName;
  final int itemQuantity;
  final String itemPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Theme.of(context).cardTheme.color,
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGreen,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.mediumGrey.withValues(
                        alpha: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.mediumGrey,
                      size: 30,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.accentGreen,
                    size: 30,
                  ),
                ),
        ),
        title: Text(
          itemName,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          "Qty: $itemQuantity  •  Price: $itemPrice",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
