import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

class SuggestionsList extends StatelessWidget {
  final String searchText;
  final TextEditingController searchController;
  final List<String> filteredProducts;

  const SuggestionsList({
    super.key,
    required this.searchText,
    required this.searchController,
    required this.filteredProducts,
  });

  @override
  Widget build(BuildContext context) {
    if (filteredProducts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('No suggestions found for "$searchText"'),
        ),
      );
    } else {
      return ListView.separated(
        itemCount: filteredProducts.length,
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  child: Image.asset(
                    "Assets/Images/Frame 400.png",
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  title: Text(filteredProducts[index]),
                  subtitle: Row(
                    children: [
                      Image.asset("Assets/Icons/star.png"),
                      Image.asset("Assets/Icons/star.png"),
                      Image.asset("Assets/Icons/star.png"),
                      Image.asset("Assets/Icons/star.png"),
                      SizedBox(width: 4),
                      Text("4.8(287)"),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                      backgroundColor: LightThemeData.secondaryDarkColor,
                    ),
                    child: Image.asset("Assets/Icons/Icons (1).png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16),
                  child: Text(
                    "\$3.99",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
