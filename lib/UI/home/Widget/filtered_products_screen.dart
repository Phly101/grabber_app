import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
import "package:grabber_app/Services/FireStore/firestore_service.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_card.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class FilteredProductsScreen extends StatelessWidget {
  final double minPrice;
  final double maxPrice;
  final List<String> selectedCategories;

  const FilteredProductsScreen({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    required this.selectedCategories,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => ItemsBloc(FirestoreService())
        ..add(FilterItems(minPrice, maxPrice, selectedCategories)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context)!.filtered_results,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, state) {
            if (state is ItemsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ItemsLoaded) {
              final filteredItems = state.items;

              if (filteredItems.isEmpty) {
                return Center(
                  child: Text(
                    LocalizationHelper.getString(context, "no_products_match_filter"),
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return BuildProductCard(
                    index: index,
                    items: filteredItems,
                  );
                },
              );
            }
            if (state is ItemsError) {
              return Center(
                child: Text(
                  "${LocalizationHelper.getString(context, "error")}: ${state.message}",
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
