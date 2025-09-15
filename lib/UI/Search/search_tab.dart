import 'package:flutter/material.dart';
import "../../l10n/app_localizations.dart";
import 'widgets/suggestions.dart';

class SearchTab extends StatefulWidget {
  static const String routeName = "Search_tab";

  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  List<String> allProducts = ["Banana", "Apple", "Grapes", "Pineapple"];
  List<String> filteredProducts = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    allProducts = [
      AppLocalizations.of(context)!.banana,
      AppLocalizations.of(context)!.apple,
      AppLocalizations.of(context)!.grapes,
      AppLocalizations.of(context)!.pineapple,
    ];
    filteredProducts = allProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
      child: Column(
        children: [
          SearchBar(
            controller: searchController,
            hintText: AppLocalizations.of(context)!.search,
            leading: Image.asset("Assets/Icons/Icons.png"),
            trailing: [
              if (searchText != "")
                IconButton(
                  onPressed: () {
                    searchText = "";
                    searchController.clear();
                    filteredProducts = allProducts;
                    setState(() {});
                  },
                  icon: Image.asset("Assets/Icons/Group 12561.png"),
                ),
            ],
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 16),
            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
                filteredProducts = allProducts
                    .where(
                      (suggestion) => suggestion.toLowerCase().contains(
                        value.toLowerCase(),
                      ),
                    )
                    .toList();
              });
            },
          ),
          SizedBox(height: 20),
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
