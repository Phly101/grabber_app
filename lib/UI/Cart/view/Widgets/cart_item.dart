import "package:flutter/material.dart";
import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";
import "package:grabber_app/UI/Cart/view/Widgets/cart_item_card.dart";
import "package:grabber_app/common/custom_card_widget.dart";
// import "shimmer_image.dart";

class CartItem extends StatelessWidget {
  final CartItemModel item;

  const CartItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CartItemCard(item: item, theme: theme);
  }
}
