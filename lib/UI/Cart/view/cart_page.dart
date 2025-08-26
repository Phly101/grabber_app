import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import 'package:shimmer/shimmer.dart';

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
          return Card(
            color: LightThemeData.primaryLightColor,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey.shade300,
                ),
              ),
              title: const Text(
                "4 bunch of banana (300g)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "\$3.45",
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: LightThemeData.surfaceColor
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const ImageIcon(AssetImage("Assets/Icons/trash-2.png")),
                          onPressed: () {},
                        ),
                        const Text("1"),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                    ],
                  )
                ],
              ),
              
            ),
          );
        },
      ),
    );
  }
}
