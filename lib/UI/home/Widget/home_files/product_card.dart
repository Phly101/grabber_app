import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_data.dart";
import "package:grabber_app/common/custom_card_widget.dart";
import "../../../../l10n/app_localizations.dart";

class BuildProductCard extends StatefulWidget {
  final int index;

  const BuildProductCard({
    super.key,
    required this.index,
  });

  @override
  State<BuildProductCard> createState() => _BuildProductCardState();
}

class _BuildProductCardState extends State<BuildProductCard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      products = [
        {
          "imagePath": "Assets/Images/Banana.png",
          "name": l10n.banana,
          "rate": l10n.rating1,
          "price": l10n.price1,
        },
        {
          "imagePath": "Assets/Images/Frame 400 (1).png",
          "name": l10n.pepper,
          "rate": l10n.rating1,
          "price": l10n.price2,
        },
        {
          "imagePath": "Assets/Images/Orange.png",
          "name": l10n.orange,
          "rate": l10n.rating1,
          "price": l10n.price3,
        },
        {
          "imagePath": "Assets/Images/Strawberry.png",
          "name": l10n.strawberry,
          "rate": l10n.rating1,
          "price": l10n.price4,
        },
        {
          "imagePath": "Assets/Images/Lemon.png",
          "name": l10n.lemon,
          "rate": l10n.rating1,
          "price": l10n.price5,
        },
        {
          "imagePath": "Assets/Images/Watermelon.png",
          "name": l10n.waterMelon,
          "rate": l10n.rating1,
          "price": l10n.price6,
        },
        {
          "imagePath": "Assets/Images/Apple.png",
          "name": l10n.apple,
          "rate": l10n.rating1,
          "price": l10n.price6,
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = products[widget.index];
    final theme = Theme.of(context);
    return CustomCardWidget(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRect(
                  child: Image.asset(
                    product["imagePath"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,

                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryDarkColor,
                    minimumSize: const Size(25, 30),
                    padding: const EdgeInsets.all(10),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.add, size: 22, color: Colors.white),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product["name"],
                    style: theme.textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFD500),
                        size: 13,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        product["rate"],
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product["price"],
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: AppColors.textButtonColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
