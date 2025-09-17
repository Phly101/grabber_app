import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_card.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_model.dart";


class ProductListView extends StatelessWidget {
  final List<Product> products;
  final String title;

  const ProductListView({
    super.key,
    required this.products,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                "See all",
                style:  TextStyle(
                  color: AppColors.textButtonColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1.3,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return BuildProductCard(product: products,index: index,);
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
