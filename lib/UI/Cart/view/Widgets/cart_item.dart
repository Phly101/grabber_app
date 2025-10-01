import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/cart%20bloc/cart_bloc.dart";
import "package:grabber_app/Blocs/cart%20bloc/cart_item_model.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/common/custom_card_widget.dart";
// import "shimmer_image.dart";
import "../../../../l10n/app_localizations.dart";

class CartItem extends StatelessWidget {
  final CartItemModel item;
  const CartItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomCardWidget(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Image.asset(item.imagePath, width: 50, height: 50),
        title: Text(
          // AppLocalizations.of(context)!.bananaBundle300g,
          // item.name, // but this remove the localization
          LocalizationHelper.getString(context, item.name),

          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (item.price * item.quantity).toString(),
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: theme.colorScheme.surface,
                  ),
                  child: Row(
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
                      Text(item.quantity.toString()),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
