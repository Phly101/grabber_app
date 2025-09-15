import "package:flutter/material.dart";
import "package:grabber_app/UI/home/Widget/home_files/Category.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_list_view.dart";
import "package:grabber_app/UI/home/Widget/home_files/slider.dart";
import "Widget/home_files/product_data.dart";

//TODO: make FloatingActionButton
//TODO: make Navigator

class HomeTab extends StatelessWidget {
  static const String routeName = "home_tab";

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          HomeSlider(),
          HomeCategory(),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                ProductListView(product: "fruit", title: 'Fruits'),
                ProductListView(product: "detergent", title: 'Detergent'),
                ProductListView(product: "biscuit", title: 'Biscuit'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
