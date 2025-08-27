import 'package:flutter/material.dart';
import 'package:grabber_app/UI/home/slider.dart';

final List<Category> categoriessList = const [
  Category(image: 'Assets/Images/category1.png', text: 'Fruits'),
  Category(image: 'Assets/Images/category2.png', text: 'Milk & egg'),
  Category(image: 'Assets/Images/category3.png', text: 'Beverages'),
  Category(image: 'Assets/Images/category4.png', text: 'Laundry'),
  Category(image: 'Assets/Images/category5.png', text: 'Vegetables'),
];

class HomeTab extends StatelessWidget {
  static const String routeName = "home_tab";

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeSlider(),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < categoriessList.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 11,
                    ),
                    child: Column(
                      children: [
                        Image.asset(categoriessList[i].image),
                        SizedBox(height: 11),
                        Text(
                          categoriessList[i].text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0CA201),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String image;
  final String text;

  const Category({required this.image, required this.text});
}
