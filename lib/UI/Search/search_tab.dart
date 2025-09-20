import "package:flutter/material.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "widgets/suggestions.dart";
import "../../l10n/app_localizations.dart";

class SearchTab extends StatefulWidget {
  static const String routeName = "Search_tab";

  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  List<String> allProducts = ["banana", "apple", "grapes", "pineapple"];
  List<String> filteredProducts = [];

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    List<String> localizedProducts = allProducts
        .map((key) => LocalizationHelper.getString(context, key))
        .toList();
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
      child: Column(
        children: [
          SearchBar(
            controller: searchController,

            hintText: AppLocalizations.of(context)!.search,
            leading: Image.asset("Assets/Icons/Icons.png",color: theme.colorScheme.onPrimary,),

            trailing: [
              if (searchText != "")
                IconButton(
                  onPressed: () {
                    searchText = "";
                    searchController.clear();
                    filteredProducts = localizedProducts;
                    setState(() {});
                  },

                  icon: Image.asset("Assets/Icons/Group 12561.png",color:theme.colorScheme.onPrimary),
                ),
            ],
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 16),

            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
                filteredProducts = localizedProducts
                    .where(
                      (suggestion) => suggestion.toLowerCase().contains(
                        value.toLowerCase(),
                      ),
                    )
                    .toList();
              });
            },
          ),

          const SizedBox(height: 20),

          Expanded(
            child: SuggestionsList(
              searchText: searchText,
              searchController: searchController,
              filteredProducts: filteredProducts,
            ),
          ),
        ],
      ),
    );
  }
}
