import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/common/custom_card_widget.dart";
import "../../../l10n/app_localizations.dart";
import "../../home/product_details/product_details.dart";

class SuggestionsList extends StatelessWidget {
  final String searchText;
  final TextEditingController searchController;
  final List<Map<String, dynamic>> filteredProducts;

  const SuggestionsList({
    super.key,
    required this.searchText,
    required this.searchController,
    required this.filteredProducts,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (filteredProducts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Text(AppLocalizations.of(context)!.noSuggestionsFound),
        ),
      );
    } else {
      return ListView.separated(
        itemCount: filteredProducts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final item = filteredProducts[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10.0,left: 10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(product: item),
                  ),
                );
              },
              child: CustomCardWidget(
                elevation: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 380,
                      height: 150,

                      child: CachedNetworkImage(
                        imageUrl: item["image_URL"],
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fill,

                      ),
                    ),
                    ListTile(
                      title: Text(
                        LocalizationHelper.localizedProductField(
                          item,
                          "title",
                          context,
                        ),
                        style: theme.textTheme.bodyLarge,
                      ),

                      trailing: ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(
                            AddItemEvent(
                              CartItemModel(
                                imagePath: item["image_URL"],
                                nameEn: item["title_en"],
                                nameAr: item["title_ar"],
                                price: item["price"],
                                id:  item["id"],
                                quantity: 1,
                              ),
                            ),
                          );
                          Fluttertoast.showToast(
                            backgroundColor: Colors.green,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            msg:
                                "${LocalizationHelper.localizedProductField(item, "title", context)} ${AppLocalizations.of(context)!.addedToCart}",
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),

                          backgroundColor: AppColors.secondaryDarkColor,
                        ),
                        child: Image.asset("Assets/Icons/Icons (1).png"),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 16),

                      child: Text(
                        LocalizationHelper.getString(
                          context,
                          'Price: ${item["price"].toString()}\$',
                        ),
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.textButtonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
