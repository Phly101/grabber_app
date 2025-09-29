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
  final List<Map<String, dynamic>> sliderList = [
    {
      "image": "Assets/Images/SliderImage1.png",
      "text": "offer30",
      "subText": "enjoyOurBigOffer",
      "backgroundColor": AppColors.primaryLightColor,
      "isDark": false,
      "index": 0,
    },
    {
      "image": "Assets/Images/SliderImage2.png",
      "text": "offer25",
      "subText": "enjoyOurBigOffer",
      "backgroundColor": AppColors.textButtonColor,
      "isDark": true,
      "index": 1,
    },
    {
      "image": "Assets/Images/SliderImage3.png",
      "text": "getSameDayDeliver",
      "subText": "enjoyOurBigOffer",
      "backgroundColor": const Color(0xFFFFDB24),
      "isDark": false,
      "index": 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: sliderList.length,
      options: CarouselOptions(
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
        viewportFraction: .77,
        autoPlayInterval: const Duration(seconds: 6),
      ),
      itemBuilder: (context, index, realIndex) {
        final slide = sliderList[index];

        return SliderWidget(slide: slide);
      },
    );
  }
}
