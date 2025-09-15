import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import "package:grabber_app/UI/home/Widget/home_files/product_card.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_data.dart";
import "../../../../l10n/app_localizations.dart";

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
                AppLocalizations.of(context)!.seeAll,
                style: const TextStyle(
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
          aspectRatio: 2.77 / 2,
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
