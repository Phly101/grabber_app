import 'package:flutter/material.dart';

import 'product_card.dart';
import 'product_data.dart';

class DetergentItems extends StatefulWidget {
  const DetergentItems({super.key});

  @override
  State<DetergentItems> createState() => _DetergentItemsState();
}

class _DetergentItemsState extends State<DetergentItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: detergent.length,
        itemBuilder: (context, index) {
          return buildProductCard(detergent[index]);
        },
      ),
    );
  }
}
