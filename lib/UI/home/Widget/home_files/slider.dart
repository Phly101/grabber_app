import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";

import "package:grabber_app/UI/home/Widget/slider_widget.dart";

class HomeSlider extends StatelessWidget {
   const HomeSlider({super.key});



  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
        viewportFraction: .77,
        autoPlayInterval: const Duration(seconds: 6),
      ),
      items: slides.map((slide) {
        return Builder(
          builder: (BuildContext context) {
            return SliderWidget(slide: slide);
          },
        );
      }).toList(),

    );
  }
}


 final List<Map<String, dynamic>> slides = [
  {
    "image": "Assets/Images/SliderImage1.png",
    "title": "Up to 30% offer",
    "subtitle": "Enjoy our big offer",
    "backgroundColor": const Color(0xffD7FFD4),
    "isDark": false,
  },
  {
    "image": "Assets/Images/SliderImage2.png",
    "title": "Up to 25% offer",
    "subtitle": "Enjoy our big offer",
    "backgroundColor": AppColors.textButtonColor,
    "isDark": true,
  },
  {
    "image": "Assets/Images/SliderImage3.png",
    "title": "Get Same day\nDeliver",
    "subtitle": "Enjoy our big offer",
    "backgroundColor": const Color(0xFFFFDB24),
    "isDark": false,
  },
];