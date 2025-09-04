import 'package:flutter/material.dart';


import 'package:grabber_app/UI/home/home_files/Category.dart';
import 'package:grabber_app/UI/home/home_files/product_data.dart';
import 'package:grabber_app/UI/home/home_files/product_list_view.dart';
import 'package:grabber_app/UI/home/home_files/slider.dart';



//TODO: make FloatingActionButton
//TODO: make Navigator


class HomeTab extends StatelessWidget {
  static const String routeName = "home_tab";

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeSlider(),
          HomeCategory(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ProductListView(products: fruit, title: 'Fruits'),
                ProductListView(products: detergent, title: 'Detergent'),
                ProductListView(products: biscuit, title: 'Biscuit'),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
