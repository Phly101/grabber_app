import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  final List<HomeSliderr> slides = const [
    HomeSliderr(
      image: 'Assets/Images/SliderImage1.png',
      text: 'Up to 30% offer',
      subText: 'Enjoy our big offer',
      backgroundColor: LightThemeData.primaryLightColor
      //Color(0xFFD7FFD4),
    ),
    HomeSliderr(
      image: 'Assets/Images/SliderImage2.png',
      text: 'Up to 25% offer',
      subText: 'Enjoy our big offer',
      backgroundColor:LightThemeData.darkPrimaryColor
    ),
    HomeSliderr(
      image: 'Assets/Images/SliderImage3.png',
      text: '''Get Same day
Deliver''',
      subText: 'Enjoy our big offer',
      backgroundColor: Color(0xFFFFDB24),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
        viewportFraction: .77,
        autoPlayInterval: Duration(seconds: 6),
      ),
      items: slides.map((slide) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                height: 222,
                width: MediaQuery.of(context).size.width * 0.83,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color:slide.backgroundColor,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            slide.text,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            slide.subText,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 11),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LightThemeData.surfaceColor,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Shop Now',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Image.asset(
                        slide.image,
                        height: 200,
                        width: 242,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class HomeSliderr {
  final String image;
  final String text;
  final String subText;
  final Color backgroundColor;

  const HomeSliderr({required this.image, required this.text, required this.subText,required this.backgroundColor});
}
