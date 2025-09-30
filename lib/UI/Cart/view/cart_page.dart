import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Blocs/cart%20bloc/cart_bloc.dart";
import "package:grabber_app/UI/Cart/view/Widgets/checkout_button.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/common/custom_card_widget.dart";
import "widgets/cart_item.dart";
import "../../../l10n/app_localizations.dart";

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.mainApp);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        automaticallyImplyLeading: false,

        title: Text(
          AppLocalizations.of(context)!.cart,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // TODO: Replace with dynamic order icon or add navigation to Orders page
          const ImageIcon(AssetImage("Assets/Icons/penIcon.png")),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              // TODO: Localize "Orders" text for multi-language support
              child: Text(
                AppLocalizations.of(context)!.cart,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state.items.isEmpty) {
                  return const Center(child: Text("Cart is empty"));
                }
                return ListView.builder(
                  //padding: EdgeInsets.only(bottom: 100),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return CartItem(
                      item: item,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomCardWidget(
              child: Material(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  //Todo: implement the onPressed function
                  onTap: () {},
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text(
                      "Send as a gift",
                      style: theme.textTheme.bodyLarge,
                    ),
                    tileColor: theme.colorScheme.surface,
                    leading: FaIcon(
                      FontAwesomeIcons.gift,
                      color: theme.colorScheme.onPrimary,
                    ),

                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      //Todo: fix the layout overlapping checkout button
      floatingActionButton: CheckoutButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.checkout);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.proceedingToCheckout),
            ),
          );
        },
      ),
      // TODO: Consider changing position if design updates (e.g., bottomNavigationBar)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
