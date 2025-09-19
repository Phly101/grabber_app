import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/Theming/app_theme_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "../../../../LocalizationHelper/localizationHelper.dart";

class HomeCategory extends StatefulWidget {
  final void Function(String category) onCategoryTap;

  const HomeCategory({super.key, required this.onCategoryTap});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  List<Map<String, dynamic>> categoriesList = [
    {"image": "Assets/Images/category1.png", "text": "fruits"},
    {"image": "Assets/Images/category2.png", "text": "milkAndEgg"},
    {"image": "Assets/Images/category3.png", "text": "beverages"},
    {"image": "Assets/Images/category4.png", "text": "laundry"},
    {"image": "Assets/Images/category5.png", "text": "vegetables"},
  ];

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
          final String text=categoriesList[index]["text"];
          return InkWell(
            onTap: () => widget.onCategoryTap(categoriesList[index]["text"]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
              child: Column(
                children: [
                  Image.asset(categoriesList[index]["image"]),
                  const SizedBox(height: 11),
                  Text(
                    LocalizationHelper.getString(context, text),
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
