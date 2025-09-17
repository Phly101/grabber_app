import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Theme/theme.dart";
import "../../../../Blocs/Theming/app_theme_bloc.dart";
class HomeCategory extends StatelessWidget {
  const HomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<AppThemeBloc>();
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriessList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
            child: Column(
              children: [
                Image.asset(categoriessList[index].image),
                const SizedBox(height: 11),
                Text(
                  categoriessList[index].text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeBloc.state.appTheme == "L"? AppColors.textButtonColor : AppColors.white
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Category {
  final String image;
  final String text;

  const Category({required this.image, required this.text});
}

final List<Category> categoriessList = const [
  Category(image: "Assets/Images/category1.png", text: "Fruits"),
  Category(image: "Assets/Images/category2.png", text: "Milk & egg"),
  Category(image: "Assets/Images/category3.png", text: "Beverages"),
  Category(image: "Assets/Images/category4.png", text: "Laundry"),
  Category(image: "Assets/Images/category5.png", text: "Vegetables"),
];
