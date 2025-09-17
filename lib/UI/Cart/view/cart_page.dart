import "package:flutter/material.dart";
import "package:grabber_app/UI/Cart/view/Widgets/checkout_button.dart";
import "package:grabber_app/Utils/routes.dart";
import "widgets/cart_item.dart";

class CartPage extends StatelessWidget {

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: (){
          Navigator.pushNamed(context, AppRoutes.mainApp);

        }, icon: const Icon(Icons.arrow_back_ios_new)),
        automaticallyImplyLeading: false,

        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          // TODO: Replace with dynamic order icon or add navigation to Orders page
          ImageIcon(AssetImage("Assets/Icons/penIcon.png")),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Center(
              // TODO: Localize "Orders" text for multi-language support
              child: Text("Orders"),
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
          Navigator.pushNamed(context, AppRoutes.checkout);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Proceeding to Checkout...")),
          );
        },
      ),
      // TODO: Consider changing position if design updates (e.g., bottomNavigationBar)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
