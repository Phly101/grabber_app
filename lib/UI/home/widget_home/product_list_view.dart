import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import 'package:grabber_app/UI/home/widget_home/product_card.dart';
import 'package:grabber_app/UI/home/widget_home/product_model.dart';

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
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all',
                style: TextStyle(
                  color: LightThemeData.darkPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 3 / 2, //card maintains its shape on any screen
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return buildProductCard(products[index]);
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
