import 'package:flutter/material.dart';
import 'package:grabber_app/Theme/light_theme.dart';
import 'product_model.dart';

Widget buildProductCard(Product product) {
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
                child: Image.asset(product.imagePath, fit: BoxFit.cover),
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
                  product.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFFFFD500), size: 13),
                    SizedBox(width: 3),
                    Text(
                      product.rate,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
