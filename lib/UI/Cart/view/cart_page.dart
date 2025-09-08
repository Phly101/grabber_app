import 'package:flutter/material.dart';
import 'widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          ImageIcon(AssetImage("Assets/Icons/Vector.png")),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Center(child: Text("Orders")),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CartItem();
        },
      ),
    );
  }
}
