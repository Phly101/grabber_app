import "package:flutter/material.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/Theme/theme.dart";


class CartItemCard extends StatelessWidget {
  final dynamic item; // replace with your model
  final ThemeData theme;

  const CartItemCard({
    super.key,
    required this.item,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final themeBloc =context.read<AppThemeBloc>();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: themeBloc.state.appTheme == "L" ? Colors.black : Colors.grey,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: item.imagePath,
                width: 120, // 👈 controlled size (change if needed)
                height: 120,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 16),

            // Product Info + Actions
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    LocalizationHelper.getString(context, item.name),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Price
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryGreen,
                      ),
                      children: [
                        TextSpan(
                          text: (item.price * item.quantity).toStringAsFixed(2),
                        ),
                        const TextSpan(text: " \$"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Quantity Controls

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.onPrimary.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: theme.colorScheme.surface,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_sharp),
                            onPressed: () {
                              if (item.quantity > 1) {
                                context.read<CartBloc>().add(
                                  DecreaseQtyEvent(item.name),
                                );
                              } else {
                                context.read<CartBloc>().add(
                                  RemoveItemEvent(item.name),
                                );
                              }
                            },
                          ),
                          Text(
                            item.quantity.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                IncreaseQtyEvent(item.name),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
