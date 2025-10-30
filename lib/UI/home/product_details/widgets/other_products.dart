import "package:flutter/material.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/l10n/app_localizations.dart";
import "package:grabber_app/Theme/theme.dart";

import "../../../../Services/FireStore/firestore_service.dart";
import "../product_details.dart";

class OtherProducts extends StatelessWidget {
  final String currentProductId;
  final Color textColor;
  final Color subtitleColor;

  const OtherProducts({
    super.key,
    required this.currentProductId,
    required this.textColor,
    required this.subtitleColor,
  });

  static const List<String> allCollections = [
    "Fruits list",
    "vegetables list",
    "egg&milk",
    "Beverages list",
    "Biscuit list",
    "Detergent list",
    "Laundry list",
  ];

  Future<List<Map<String, dynamic>>> _fetchOtherProducts() async {
    try {
      final firestoreService = FirestoreService();
      List<Map<String, dynamic>> allProducts = [];

      for (var collection in allCollections) {
        try {
          final items = await firestoreService.getItems(collection).first;
          allProducts.addAll(items);
        } catch (e) {
          debugPrint("Error fetching from $collection: $e");
        }
      }

      allProducts.removeWhere((item) => item["id"] == currentProductId);
      allProducts.shuffle();
      return allProducts.take(6).toList();
    } catch (e) {
      debugPrint("Error in _fetchOtherProducts: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    if (loc == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final relatedCardColor = isDark ? AppColors.darkSurface : const Color(0xFFDEF7E4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.otherProducts,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchOtherProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(
                loc.errorLoadingProducts,
                style: const TextStyle(color: Colors.red),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text(
                loc.noProductsAvailable,
                style: TextStyle(color: subtitleColor),
              );
            }

            final otherProducts = snapshot.data!;

            return SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: otherProducts.length,
                itemBuilder: (context, index) {
                  final item = otherProducts[index];
                  final imageUrl = item["image_URL"] ?? "";
                  final itemPrice = item["price"] ?? 0;

                  // Product Card integrated here
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(product: item),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: relatedCardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withAlpha(3)
                                : Colors.grey.withAlpha(1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: imageUrl.isNotEmpty
                                ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF4CAF50),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.grey, size: 40),
                            )
                                : Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocalizationHelper.localizedProductField(
                                    item,
                                    "title",
                                    context,
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: textColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\$$itemPrice",
                                  style: const TextStyle(
                                    color: Color(0xFF4CAF50),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}