import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
import "package:grabber_app/Services/FireStore/firestore_service.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_card.dart";
import "package:grabber_app/l10n/app_localizations.dart";




class ProductListView extends StatelessWidget {
  final String title;
  final String collectionName;

  const ProductListView({
    super.key,
    required this.title,
    required product,
    required this.collectionName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ItemsBloc(FirestoreService())..add(LoadItems(collectionName)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1.38,
            child: BlocBuilder<ItemsBloc, ItemsState>(
              builder: (context, state) {
                if (state is ItemsLoading) {
                   return const Center(child: CircularProgressIndicator());
                } else if (state is ItemsLoaded) {
                  final items = state.items;
                  return ListView.builder(
                   key: const Key("product_listview"),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return BuildProductCard(
                        index: index,
                        items: items,
                      );
                    },
                  );
                } else if (state is ItemsError) {
                  return Center(child: Text("${AppLocalizations.of(context)!.error}: ${state.message}"));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
