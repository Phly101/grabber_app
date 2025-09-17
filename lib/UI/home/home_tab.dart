import "package:flutter/material.dart";
import "package:grabber_app/UI/home/Widget/home_files/category.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_data.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_list_view.dart";
import "package:grabber_app/UI/home/Widget/home_files/slider.dart";




//TODO: make FloatingActionButton
//TODO: make Navigator


class HomeTab extends StatelessWidget {


  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeSlider(),
          const HomeCategory(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ProductListView(products: fruit, title: "Fruits"),
                ProductListView(products: detergent, title: "Detergent"),
                ProductListView(products: biscuit, title: "Biscuit"),
              ],
            ),
          ),


        ],
      ),
    );

    

  }
}
