
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/cart%20bloc/cart_bloc.dart";
import "package:grabber_app/Blocs/cart%20bloc/cart_item_model.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/common/custom_card_widget.dart";

import "../../../l10n/app_localizations.dart";


class SuggestionsList extends StatelessWidget {
  final String searchText;
  final TextEditingController searchController;
  final List<String> filteredProducts;

  const SuggestionsList({
    super.key,
    required this.searchText,
    required this.searchController,
    required this.filteredProducts,
  });

  @override
  Widget build(BuildContext context) {
  final theme =Theme.of(context);


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
          final name = filteredProducts[index];   // name to string type
          return CustomCardWidget(
            elevation: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(

                  width: double.infinity,
                  height: 150,
                  child: Image.asset(
                    "Assets/Images/Frame 400.png",
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  title: Text(filteredProducts[index],style: theme.textTheme.bodyLarge,),
                  subtitle: Row(
                    children: [
                      Image.asset("Assets/Icons/star.png"),
                      Image.asset("Assets/Icons/star.png"),
                      Image.asset("Assets/Icons/star.png"),
                      Image.asset("Assets/Icons/star.png"),

                      const SizedBox(width: 4),
                       Text("4.8(287)",style: theme.textTheme.bodyLarge,),

                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                        context.read<CartBloc>().add(
                          AddItemEvent(
                            CartItemModel(  // using product static
                              imagePath: "Assets/Images/Frame 400.png",
                              name: name,
                              price: 3.6,
                              quantity: 1,
                            ),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("$name added to cart")),
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
                    "\$3.99",
                    style: theme.textTheme.bodyLarge!.copyWith(color: AppColors.textButtonColor)
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
