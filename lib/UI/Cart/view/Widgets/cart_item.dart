import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import 'shimmer_image.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: LightThemeData.primaryLightColor,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const ShimmerImage(size: 50),
        title: const Text(
          "4 bunch of banana (300g)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
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
                    color: LightThemeData.surfaceColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const ImageIcon(
                          AssetImage("Assets/Icons/trash-2.png"),
                        ),
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
  }
}
