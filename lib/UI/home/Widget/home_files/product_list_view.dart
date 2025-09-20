import "package:flutter/material.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_card.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_data.dart";
class ProductListView extends StatelessWidget {
  final String title;

  const ProductListView({
    super.key,
    required this.title,
    required product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
          ],
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1.28,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return BuildProductCard(
                index: index,
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
