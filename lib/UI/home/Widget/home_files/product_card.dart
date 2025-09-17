import "package:flutter/material.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/home/Widget/home_files/product_model.dart";

class BuildProductCard extends StatelessWidget {
  final List<Product> product;
  final int index;
  const BuildProductCard({super.key,  required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRect(
                  child: Image.asset(product[index].imagePath, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                  right: 12,
                  bottom: 12,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryDarkColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // removes extra min constraints
                    ),
                    child: const Icon(Icons.add, size: 20, color: Colors.white),
                  )

              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product[index].name,
                    style:Theme.of(context).textTheme.titleMedium!.copyWith( fontWeight: FontWeight.bold,),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Color(0xFFFFD500), size: 13),
                      const SizedBox(width: 3),
                      Text(
                        product[index].rate,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      product[index].price,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryGreen),
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





