import 'package:flutter/material.dart';

import 'product_card.dart';
import 'product_data.dart';

class BiscuitItems extends StatefulWidget {
  const BiscuitItems({super.key});

  @override
  State<BiscuitItems> createState() => _BiscuitItemsState();
}

class _BiscuitItemsState extends State<BiscuitItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: biscuit.length,
        itemBuilder: (context, index) {
          return buildProductCard(biscuit[index]);
        },
      ),
    );
  }
}
