import "package:flutter/material.dart";
import "package:grabber_app/common/custom_card_widget.dart";

class ListItems extends StatelessWidget {
  final String? title;
  final num? count;
  final num? price;

  const ListItems({
    super.key,
    required this.title,
    required this.count,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: ListTile(
        trailing: Text("\$${(price! * count!).toStringAsFixed(2)}",style: Theme.of(context).textTheme.titleMedium,),
        title: Text("${title!} x $count",style: Theme.of(context).textTheme.titleMedium, ),

      ),
    );
  }
}
