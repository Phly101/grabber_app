import "package:flutter/cupertino.dart";
import "package:grabber_app/Theme/light_theme.dart";
import "package:grabber_app/l10n/app_localizations.dart";

class HomeCategory extends StatefulWidget {
  const HomeCategory({super.key});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
List<Map<String, dynamic>> categoriessList = [
  {"image": "Assets/Images/category1.png", "text": "Fruits"},
  {"image": "Assets/Images/category2.png", "text": "Milk & egg"},
  {"image": "Assets/Images/category3.png", "text": "Beverages"},
  {"image": "Assets/Images/category4.png", "text": "Laundry"},
  {"image": "Assets/Images/category5.png", "text": "Vegetables"},
  ];

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  final l10n=AppLocalizations.of(context)!;
  setState(() {
    categoriessList=[
      {"image": "Assets/Images/category1.png", "text": l10n.fruits},
      {"image": "Assets/Images/category2.png", "text": l10n.milkAndEgg},
      {"image": "Assets/Images/category3.png", "text": l10n.beverages},
      {"image": "Assets/Images/category4.png", "text": l10n.laundry},
      {"image": "Assets/Images/category5.png", "text": l10n.vegetables},
    ];
  });
}
  @override
  Widget build(BuildContext context) {
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
                Image.asset(categoriessList[index]["image"]),
                SizedBox(height: 11),
                Text(
                  //AppLocalizations.of(context)!.
                  categoriessList[index]["text"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (LightThemeData.darkPrimaryColor),
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