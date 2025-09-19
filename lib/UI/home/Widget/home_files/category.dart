import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class HomeCategory extends StatefulWidget {
  final void Function(String category) onCategoryTap;

  const HomeCategory({super.key, required this.onCategoryTap});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  List<Map<String, dynamic>> categoriesList = [
    {"image": "Assets/Images/category1.png", "text": "Fruits"},
    {"image": "Assets/Images/category2.png", "text": "Milk & egg"},
    {"image": "Assets/Images/category3.png", "text": "Beverages"},
    {"image": "Assets/Images/category4.png", "text": "Laundry"},
    {"image": "Assets/Images/category5.png", "text": "Vegetables"},
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      categoriesList = [
        {"image": "Assets/Images/category1.png", "text": l10n.fruits},
        {"image": "Assets/Images/category2.png", "text": l10n.milkAndEgg},
        {"image": "Assets/Images/category3.png", "text": l10n.beverages},
        {"image": "Assets/Images/category4.png", "text": l10n.laundry},
        {"image": "Assets/Images/category5.png", "text": l10n.vegetables},
        {"image": "Assets/Images/category6.png", "text": l10n.biscoff},
        {"image": "Assets/Images/category7.png", "text": l10n.detergent},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeBloc = context.read<AppThemeBloc>();
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => widget.onCategoryTap(categoriesList[index]["text"]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
              child: Column(
                children: [
                  Image.asset(categoriesList[index]["image"]),
                  const SizedBox(height: 11),
                  Text(
                    //AppLocalizations.of(context)!.
                    categoriesList[index]["text"],
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: themeBloc.state.appTheme == "L"
                          ? AppColors.textButtonColor
                          : AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
