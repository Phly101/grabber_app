import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_data.dart";
import "package:grabber_app/common/custom_card_widget.dart";
import "../../../../LocalizationHelper/localizationHelper.dart";
import "../../../../l10n/app_localizations.dart";

class BuildProductCard extends StatelessWidget {
  final int index;

  const BuildProductCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final product = products[index];
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
                    LocalizationHelper.getString(context, product["name"]),
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
                       LocalizationHelper.getString(context, product["rating48With287"]) ,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                   LocalizationHelper.getString(context, product["price1"]),
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
