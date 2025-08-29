import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import 'package:grabber_app/UI/home/slider.dart';
import 'Category.dart';
import 'biscuit_items.dart';
import 'detergent_items.dart';
import 'fruit_items.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
            child: Row(
              children: [
                Text(
                  'Fruits',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: LightThemeData.darkPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AspectRatio(
            //card maintains its shape on any screen.
            aspectRatio: 3 / 2,
            child: FruitsItems(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Detergent',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: LightThemeData.darkPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AspectRatio(
            //card maintains its shape on any screen.
            aspectRatio: 3 / 2,
            child: DetergentItems(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Biscuit',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: LightThemeData.darkPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AspectRatio(
            //card maintains its shape on any screen.
            aspectRatio: 3 / 2,
            child: BiscuitItems(),
          ),

        ],
      ),
    );
  }
}
