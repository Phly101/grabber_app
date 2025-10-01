import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/common/custom_card_widget.dart";

class BuildProductCard extends StatelessWidget {
  final int index;
  final dynamic items;
  const BuildProductCard({super.key, required this.index, required this.items});

  @override
  Widget build(BuildContext context) {
    final item = items[index];
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
                  child:
                      CachedNetworkImage(
                        imageUrl: item["image_URL"],
                        placeholder: (context, url) =>
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fill,
                        width: 200,
                        height: 150,
                      ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,

                child: ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(
                      AddItemEvent(
                        CartItemModel(
                          imagePath: item["image_URL"],
                          name: item["title_en"],
                          price: 3.6,
                          quantity: 1
                        )
                      )
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added to cart"))
                    );
                  },
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
                    LocalizationHelper.getString(context, item["title_en"]),
                    style: theme.textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LocalizationHelper.getString(
                      context,
                      'Price: ${item["price"].toString()}\$',
                    ),
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
