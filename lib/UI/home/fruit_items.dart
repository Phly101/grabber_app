import 'package:flutter/material.dart';

import 'product_card.dart';
import 'product_data.dart';

class FruitsItems extends StatefulWidget {
  const FruitsItems({super.key});

  @override
  State<FruitsItems> createState() => _FruitsItemsState();
}

class _FruitsItemsState extends State<FruitsItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: fruit.length,
        itemBuilder: (context, index) {
          return buildProductCard(fruit[index]);
        },
      ),
    );
  }
}
