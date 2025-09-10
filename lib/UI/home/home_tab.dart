import 'package:flutter/material.dart';
import 'package:grabber_app/UI/checkout/checkout_screen.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = "home_tab";

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, CheckoutScreen.routeName);
            },
            child: Text(
              "Click to view Checkout  screen",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
