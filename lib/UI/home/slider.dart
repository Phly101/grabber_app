import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  final List<HomeSliderr> slides = const [
    HomeSliderr(
      image: 'Assets/Images/SliderImage1.png',
      text: 'Up to 30% offer',
      subText: 'Enjoy our big offer',
      backgroundColor:  Color(0xFFD7FFD4),
    ),
    HomeSliderr(
      image: 'Assets/Images/SliderImage2.png',
      text: 'Up to 25% offer',
      subText: 'Enjoy our big offer',
      backgroundColor:Color(0xFF0CA201),
    ),
    HomeSliderr(
      image: 'Assets/Images/SliderImage3.png',
      text: 'Get Same day Deliver',
      subText: 'Enjoy our big offer',
      backgroundColor: Color(0xFFFFDB24),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        autoPlay: true,
        viewportFraction: .77,
        autoPlayInterval: Duration(seconds: 6),
      ),
      items: slides.map((slide) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child: Container(margin: EdgeInsets.zero,
                height: 222,
                width: MediaQuery.of(context).size.width * 0.83,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color:slide.backgroundColor,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            slide.text,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 11),
                          Text(
                            slide.subText,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
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
                        height: 155,
                        width: 232,
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
