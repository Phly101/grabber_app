import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import 'package:grabber_app/UI/home/slider.dart';

import 'Category.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = "home_tab";

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [HomeSlider(), HomeCategory()]),
    );
  }
}
