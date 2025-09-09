import 'package:flutter/material.dart';


class HomeTab extends StatelessWidget {
  static const String routeName = "home_tab";

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Click to view Payment screen"),

        ],
      ),
    );
  }
}
