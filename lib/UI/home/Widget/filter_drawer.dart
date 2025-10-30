import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/localization/app_locale_bloc.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/UI/home/Widget/filtered_products_screen.dart";
import "package:grabber_app/UI/home/Widget/home_files/components/filter_drawer_footer.dart";

import "package:grabber_app/UI/home/Widget/home_files/components/filter_drawer_header.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  RangeValues _priceRange = const RangeValues(0, 600);
  final List<String> categoriesEn = const [
    "Beverages list",
    "Detergent list",
    "Vegetables list",
    "Biscuit list",
    "Fruits list",
    "Laundry list",
    "Milk & egg list",
  ];
  final List<String> categoriesAr = const [
    "قائمة المشروبات",
    "قائمة المنظفات",
    "قائمة الخضروات",
    "قائمة البسكويت",
    "قائمة الفواكه",
    "قائمة الغسيل",
    "قائمة الحليب والبيض",
  ];

  final Map<String, String> categoryKeysEn = {
    "Beverages list": "beverages",
    "Detergent list": "detergent",
    "Vegetables list": "vegetables",
    "Biscuit list": "biscuit",
    "Fruits list": "fruits",
    "Laundry list": "laundry",
    "Milk & egg list": "milk_egg",
  };
  final Map<String, String> categoryKeysAr = {
    "قائمة المشروبات": "المشروبات",
    "قائمة المنظفات": "المنظفات",
    "قائمة الخضروات": "الخضروات",
    "قائمة البسكويت": "البسكويت",
    "قائمة الفواكه": "الفواكه",
    "قائمة الغسيل": "الغسيل",
    "قائمة الحليب والبيض": "الحليب والبيض",
  };


  final Set<String> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = context.read<LocaleBloc>();

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilterDrawerHeader(titleKey: AppLocalizations.of(context)!.filter_products,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    AppLocalizations.of(context)!.price_range,
                      style: theme.textTheme.bodyLarge,
                    ),
                    RangeSlider(
                      values: _priceRange,
                      min: 0,
                      max: 1000,
                      divisions: 100,
                      labels: RangeLabels(
                        "\$${_priceRange.start.toStringAsFixed(0)}",
                        "\$${_priceRange.end.toStringAsFixed(0)}",
                      ),
                      activeColor: theme.colorScheme.primary,
                      inactiveColor:
                      theme.colorScheme.primary.withValues(alpha: 0.3),
                      onChanged: (val) => setState(() => _priceRange = val),
                    ),
                    const Divider(),
                    Text(
                      AppLocalizations.of(context)!.category,
                      style: theme.textTheme.bodyLarge,
                    ),
                    Expanded(
                      child: ListView(
                        children: local.state.langCode =="en" ? categoriesEn.map((cat) {
                          return CheckboxListTile(
                            value: selectedCategories.contains(cat),
                            title: Text(
                              LocalizationHelper.getString(
                                  context, categoryKeysEn[cat] ?? "erroen"),
                              style: theme.textTheme.bodyMedium,
                            ),
                            activeColor: theme.colorScheme.primary,
                            onChanged: (v) {
                              setState(() {
                                v == true
                                    ? selectedCategories.add(cat)
                                    : selectedCategories.remove(cat);
                              });
                            },
                          );
                        }).toList():
                        categoriesAr.map((cat) {
                          return CheckboxListTile(
                            value: selectedCategories.contains(cat),
                            title: Text(
                              LocalizationHelper.getString(
                                  context, categoryKeysAr[cat] ?? "errorAr"),
                              style: theme.textTheme.bodyMedium,
                            ),
                            activeColor: theme.colorScheme.primary,
                            onChanged: (v) {
                              setState(() {
                                v == true
                                    ? selectedCategories.add(cat)
                                    : selectedCategories.remove(cat);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppElevatedButton(
                      textKey: AppLocalizations.of(context)!.applyFilter,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FilteredProductsScreen(
                              minPrice: _priceRange.start,
                              maxPrice: _priceRange.end,
                              selectedCategories: selectedCategories.toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
