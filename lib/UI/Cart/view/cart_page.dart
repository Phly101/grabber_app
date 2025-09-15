import 'package:flutter/material.dart';
import 'package:grabber_app/UI/Cart/view/Widgets/checkout_button.dart';
import "package:grabber_app/UI/checkout/checkout_screen.dart";
import "../../../l10n/app_localizations.dart";
import 'widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.cart,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // TODO: Replace with dynamic order icon or add navigation to Orders page
          const ImageIcon(AssetImage("Assets/Icons/Vector.png")),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              // TODO: Localize "Orders" text for multi-language support
              child: Text(AppLocalizations.of(context)!.orders),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          // TODO: Replace with dynamic list from cart provider / state management
          return const CartItem();
        },
      ),
      floatingActionButton: CheckoutButton(
        onPressed: () {
          Navigator.pushNamed(context, CheckoutScreen.routeName);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.proceedingToCheckout)),
          );
        },
      ),
      // TODO: Consider changing position if design updates (e.g., bottomNavigationBar)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
