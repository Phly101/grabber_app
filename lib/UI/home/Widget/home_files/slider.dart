import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/home/Widget/slider_widget.dart";
import "../../../../l10n/app_localizations.dart";

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
      "subText": "Enjoy our big offer",
      "backgroundColor": AppColors.primaryLightColor,
    },
    {
      "image": "Assets/Images/SliderImage2.png",
      "text": "Up to 25% offer",
      "subText": "Enjoy our big offer",
      "backgroundColor": AppColors.textButtonColor,
    },
    {
      "image": "Assets/Images/SliderImage3.png",
      "text": "Get Same day\nDeliver",
      "subText": "Enjoy our big offer",
      "backgroundColor": const Color(0xFFFFDB24),
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      sliderList = [
        {
          "image": "Assets/Images/SliderImage1.png",
          "text": l10n.offer30,
          "subText": l10n.enjoyOurBigOffer,
          "backgroundColor": AppColors.primaryLightColor,
          "isDark": false,
          "isLight": true,
        },
        {
          "image": "Assets/Images/SliderImage2.png",
          "text": l10n.offer25,
          "subText": l10n.enjoyOurBigOffer,
          "backgroundColor": AppColors.textButtonColor,
          "isDark": true,
          "isLight": false,
        },
        {
          "image": "Assets/Images/SliderImage3.png",
          "text": l10n.getSameDayDeliver,
          "subText": l10n.enjoyOurBigOffer,
          "backgroundColor": const Color(0xFFFFDB24),
          "isDark": false,
          "isLight": false,
        },
      ];
    });
  }

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
