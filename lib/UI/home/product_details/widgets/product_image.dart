import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class ProductImage extends StatelessWidget {
  final Map<String, dynamic> product;
  final Color backgroundColor;

  const ProductImage({
    super.key,
    required this.product,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = product["image_URL"] ?? "";

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Hero(
        tag: product["id"] ?? "product_${DateTime.now().millisecondsSinceEpoch}",
        child: Center(
          child: imageUrl.isNotEmpty
              ? CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const SizedBox(
              height: 220,
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
              ),
            ),
            errorWidget: (context, url, error) => const SizedBox(
              height: 220,
              child: Center(
                child: Icon(Icons.error, color: Colors.grey, size: 80),
              ),
            ),
            fit: BoxFit.contain,
            height: 220,
          )
              : const SizedBox(
            height: 220,
            child: Center(
              child: Icon(Icons.image_not_supported, color: Colors.grey, size: 80),
            ),
          ),
        ),
      ),
    );
  }
}
