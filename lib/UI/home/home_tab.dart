import "package:flutter/material.dart";
import "package:grabber_app/UI/home/Widget/home_files/category.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_list_view.dart";
import "package:grabber_app/UI/home/Widget/home_files/slider.dart";
import "../../l10n/app_localizations.dart";

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final fruitKey = GlobalKey();
  final milkKey = GlobalKey();
  final beveragesKey = GlobalKey();
  final laundryKey = GlobalKey();
  final vegetablesKey = GlobalKey();
  final biscuitKey = GlobalKey();
  final detergentKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeSlider(),
          HomeCategory(
            onCategoryTap: (category) {
              switch (category) {
                case "Fruits":
                  scrollTo(fruitKey);
                  break;
                case "Milk & egg":
                  scrollTo(milkKey);
                  break;
                case "Beverages":
                  scrollTo(beveragesKey);
                  break;
                case "Laundry":
                  scrollTo(laundryKey);
                  break;
                case "Vegetables":
                  scrollTo(vegetablesKey);
                  break;
                case "Biscuit":
                  scrollTo(biscuitKey);
                  break;
                case "Detergent":
                  scrollTo(detergentKey);
                  break;
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ProductListView(
                  key: milkKey,
                  product: "Milk & egg",
                  title: AppLocalizations.of(context)!.milkAndEgg,
                  collectionName: "egg&milk",
                ),
                ProductListView(
                  key: beveragesKey,
                  product: "Beverages",
                  title: AppLocalizations.of(context)!.beverages,
                  collectionName: "Beverages list",
                ),
                ProductListView(
                  key: laundryKey,
                  product: "laundry",
                  title: AppLocalizations.of(context)!.laundry,
                  collectionName: "Laundry list",
                ),
                ProductListView(
                  key: vegetablesKey,
                  product: "vegetables",
                  title: AppLocalizations.of(context)!.vegetables,
                  collectionName: "vegetables list",
                ),
                ProductListView(
                  key: biscuitKey,
                  product: "biscuit",
                  title: AppLocalizations.of(context)!.biscuit,
                  collectionName: "Biscuit list",
                ),
                ProductListView(
                  key: detergentKey,
                  product: "Detergent",
                  title: AppLocalizations.of(context)!.detergent,
                  collectionName: "Detergent list",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
