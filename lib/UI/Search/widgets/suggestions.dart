
import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";

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
          return Card(
            elevation: 4,
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
                  title: Text(filteredProducts[index]),
                  subtitle: Row(
                    children: [
                      Image.asset("Assets/Icons/star.png"),
                      Image.asset("Assets/Icons/star.png"),
                      Image.asset("Assets/Icons/star.png"),
                      Image.asset("Assets/Icons/star.png"),

                      const SizedBox(width: 4),
                      const Text("4.8(287)"),

                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),

                      backgroundColor: AppColors.secondaryDarkColor,

                    ),
                    child: Image.asset("Assets/Icons/Icons (1).png"),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 16),

                  child: Text(
                    "\$3.99",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
