import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class AddToCartButton extends StatelessWidget {
  final Map<String, dynamic> product;
  final int quantity;

  const AddToCartButton({
    super.key,
    required this.product,
    required this.quantity,
  });

  void _handleAddToCart(BuildContext context) {
    try {
      final cartBloc = context.read<CartBloc>();
      final loc = AppLocalizations.of(context);
      if (loc == null) return;

      if (quantity <= 0) {
        Fluttertoast.showToast(
          msg: loc.pleaseSelectQuantity ?? "Please select quantity first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }

      final existingItem = cartBloc.state.items.firstWhere(
            (item) => item.id == product["id"],
        orElse: () => CartItemModel(
          id: "",
          imagePath: "",
          nameEn: "",
          price: 0,
          quantity: 0,
        ),
      );

      if (existingItem.id.isNotEmpty) {
        final difference = quantity - existingItem.quantity;

        if (difference > 0) {
          cartBloc.add(
            AddItemEvent(
              CartItemModel(
                imagePath: product["image_URL"] ?? "",
                nameEn: product["title_en"] ?? "",
                nameAr: product["title_ar"] ?? "",
                price: product["price"] ?? 0,
                id: product["id"] ?? "",
                quantity: difference,
              ),
            ),
          );
        } else if (difference < 0) {
          for (int i = 0; i < difference.abs(); i++) {
            cartBloc.add(DecreaseQtyEvent(product["id"] ?? ""));
          }
        } else {
          Fluttertoast.showToast(
            msg: loc.itemAlreadyInCart ?? "Item already in cart with same quantity",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
          );
          return;
        }
      } else {
        cartBloc.add(
          AddItemEvent(
            CartItemModel(
              imagePath: product["image_URL"] ?? "",
              nameEn: product["title_en"] ?? "",
              nameAr: product["title_ar"] ?? "",
              price: product["price"] ?? 0,
              id: product["id"] ?? "",
              quantity: quantity,
            ),
          ),
        );
      }

      Fluttertoast.showToast(
        msg: "${LocalizationHelper.localizedProductField(product, "title", context)} ${loc.addedToCart}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      debugPrint("Error adding to cart: $e");
      Fluttertoast.showToast(
        msg: "Error adding to cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    if (loc == null) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _handleAddToCart(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          loc.addToCart,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}