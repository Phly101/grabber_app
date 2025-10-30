import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
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
  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    context.read<ItemsBloc>().add(const LoadItems("products"));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ItemsError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is ItemsLoaded) {
          allProducts = state.items;

          filteredProducts = allProducts
              .where(
                (item) => item["title_en"].toString().toLowerCase().contains(
                  searchText.toLowerCase(),
                ),
              )
              .toList();

          return Padding(
            padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
            child: Column(
              children: [
                SearchBar(
                  key: const Key("searchText"),
                  controller: searchController,

                  hintText: AppLocalizations.of(context)!.search,
                  leading: Image.asset(
                    "Assets/Icons/Icons.png",
                    color: theme.colorScheme.onPrimary,
                  ),

                  trailing: [
                    if (searchText != "")
                      IconButton(
                        key: const Key("clearButton"),
                        onPressed: () {
                          setState(() {
                            searchText = "";
                            searchController.clear();
                          });
                        },
                        icon: Image.asset(
                          "Assets/Icons/Group 12561.png",
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                  ],
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
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
        return const SizedBox.shrink();
      },
    );
  }
}
