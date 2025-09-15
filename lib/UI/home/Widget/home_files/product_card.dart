import 'package:flutter/material.dart';
import "package:grabber_app/Theme/light_theme.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_data.dart";

import "../../../../l10n/app_localizations.dart";

class BuildProductCard extends StatefulWidget {
  final int index;
  const BuildProductCard({
    super.key,
    required this.index,
  });

  @override
  State<BuildProductCard> createState() => _BuildProductCardState();
}

class _BuildProductCardState extends State<BuildProductCard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      products=[
        {
          "imagePath": 'Assets/Images/Banana.png',
          "name": l10n.banana,
          "rate": '4.8 (287)',
          "price": '\$5.29',
        },
        {
          "imagePath": 'Assets/Images/Frame 400 (1).png',
          "name": l10n.pepper,
          "rate": '4.8 (287)',
          "price": '\$2.99',
        },
        {
          "imagePath": 'Assets/Images/Orange.png',
          "name": l10n.orange,
          "rate": '4.8 (287)',
          "price": '\$3.99',
        },
        {
          "imagePath": 'Assets/Images/Strawberry.png',
          "name": l10n.strawberry,
          "rate": '4.8 (287)',
          "price": '\$1.99',
        },
        {
          "imagePath": 'Assets/Images/Lemon.png',
          "name": l10n.lemon,
          "rate": '4.8 (287)',
          "price": '\$1.99',
        },
        {
          "imagePath": "Assets/Images/Watermelon.png",
          "name": l10n.waterMelon,
          "rate": '4.8 (287)',
          "price": '\$1.99',
        },
        {
          "imagePath": 'Assets/Images/Apple.png',
          "name": l10n.apple,
          "rate": '4.8 (287)',
          "price": '\$1.99',
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = products[widget.index];
    return Card(
      elevation: 3,
      //color: Color(0xFFEBFFD7),
      color: LightThemeData.primaryLightColor,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRect(
                  child: Image.asset(
                    product["imagePath"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 110,
                left: 105,

                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: Color(0xFF6CC51D),
                    backgroundColor: LightThemeData.secondaryDarkColor,
                    //padding: EdgeInsets.all(8),
                    minimumSize: Size(25, 30),
                    shape: CircleBorder(),
                  ),
                  child: Icon(Icons.add, size: 22, color: Colors.white),
                ),
              ),
            ],
          ),
          Expanded(
            //padding: const EdgeInsets.only(top: 130,left: 8.0,right: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product["name"],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Color(0xFFFFD500), size: 13),
                      SizedBox(width: 3),
                      Text(
                        product["rate"],
                        style: TextStyle(fontSize: 15,color: Colors.black,),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    product["price"],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
