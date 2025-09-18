import "package:flutter/material.dart";
import "package:grabber_app/UI/home/Widget/home_files/Category.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_list_view.dart";
import "package:grabber_app/UI/home/Widget/home_files/slider.dart";
import "../../l10n/app_localizations.dart";

//TODO: make FloatingActionButton
//TODO: make Navigator

class HomeTab extends StatelessWidget {


  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeSlider(),
          const HomeCategory(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ProductListView(product: "fruit", title: AppLocalizations.of(context)!.fruits),
                ProductListView(product: "detergent", title: AppLocalizations.of(context)!.detergent),
                ProductListView(product: "biscuit", title: AppLocalizations.of(context)!.biscuit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
