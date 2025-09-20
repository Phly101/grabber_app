import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/home/Widget/slider_widget.dart";


class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  List<Map<String, dynamic>> sliderList = [
    {
      "image": "Assets/Images/SliderImage1.png",
      "text": "Up to 30% offer",
      "subText": "Enjoy Our Big Offer",
      "backgroundColor": AppColors.primaryLightColor,
      "isDark": false,

    },
    {
      "image": "Assets/Images/SliderImage2.png",
      "text": "Up to 25% offer",
      "subText": "Enjoy Our Big Offer",
      "backgroundColor": AppColors.textButtonColor,
      "isDark": false,

    },
    {
      "image": "Assets/Images/SliderImage3.png",
      "text": "Get Same Day Deliver",
      "subText": "Enjoy Our Big Offer",
      "backgroundColor": const Color(0xFFFFDB24),
      "isDark": false,
    },
  ];


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
      items: sliderList.map((slide) {
        return Builder(
          builder: (BuildContext context) {
            return SliderWidget(slide: slide);
          },
        );
      }).toList(),
    );
  }
}
