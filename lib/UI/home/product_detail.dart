import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";
import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/l10n/app_localizations.dart";
import "../../Blocs/localization/app_locale_bloc.dart";
import "package:badges/badges.dart" as badges;
import "package:grabber_app/Services/FireStore/firestore_service.dart";

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    final cartBloc = context.read<CartBloc>();
    final existingItem = cartBloc.state.items.firstWhere(
          (item) => item.id == widget.product["id"],
      orElse: () => CartItemModel(
        id: "",
        imagePath: "",
        nameEn: "",
        price: 0,
        quantity: 1,
      ),
    );

    if (existingItem.id.isNotEmpty) {
      setState(() {
        quantity = existingItem.quantity;
      });
    }
  }

  final List<String> allCollections = [
    "Fruits list",
    "vegetables list",
    "egg&milk",
    "Beverages list",
    "Biscuit list",
    "Detergent list",
    "Laundry list",
  ];

  Future<List<Map<String, dynamic>>> _fetchOtherProducts() async {
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

    allProducts.removeWhere((item) => item["id"] == widget.product["id"]);

    allProducts.shuffle();
    return allProducts.take(6).toList();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isArabic = context.select<LocaleBloc, bool>(
            (bloc) => bloc.state.langCode == "ar"
    );

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = colorScheme.surface;
    final cardColor = isDark ? AppColors.darkSurface : const Color(0xFFF5F5F5);
    final textColor = colorScheme.onSurface;
    final subtitleColor = isDark ? AppColors.darkMediumGrey : Colors.grey[750];
    final relatedCardColor = isDark ? AppColors.darkSurface : const Color(0xFFDEF7E4);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          BlocSelector<CartBloc, CartState, int>(
            selector: (state) => state.totalItems,
            builder: (context, totalItems) {
              return IconButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
                icon: badges.Badge(
                  showBadge: totalItems > 0,
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.red,
                    padding: EdgeInsets.all(5),
                  ),
                  badgeContent: Text(
                    totalItems.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.cartShopping,
                    color: textColor,
                    size: 24,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Container(
                width: double.infinity,
                color: backgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Hero(
                  tag: widget.product["id"],
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.product["image_URL"],
                      placeholder: (context, url) => const SizedBox(
                        height: 220,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF4CAF50),
                          ),
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
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Details Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withAlpha(30)
                          : Colors.grey.withAlpha(50),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalizationHelper.localizedProductField(
                        widget.product,
                        "title",
                        context,
                      ),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 10),

                    //Price/Quantity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${widget.product["price"]}",
                          style: const TextStyle(
                            fontSize: 22,
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (quantity > 1) setState(() => quantity--);
                                },
                                icon: const Icon(Icons.remove, size: 20),
                                color: quantity > 1
                                    ? const Color(0xFF4CAF50)
                                    : subtitleColor,
                              ),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => setState(() => quantity++),
                                icon: const Icon(Icons.add, size: 20),
                                color: const Color(0xFF4CAF50),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // Description
                    Text(
                      loc.description,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      LocalizationHelper.localizedProductField(
                        widget.product,
                        "description",
                        context,
                      ).isNotEmpty
                          ? LocalizationHelper.localizedProductField(
                        widget.product,
                        "description",
                        context,
                      )
                          : loc.aReliableHighQualityProductDesignedToMakeEverydayLifeEasierAndBetterPerfectForDailyUseWithGreatValueAndFreshness,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: subtitleColor,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Other Products
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            loc.errorLoadingProducts,
                            style: const TextStyle(color: Colors.red),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
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
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetail(product: item),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 200,
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 6),
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
                                        child: CachedNetworkImage(
                                          imageUrl: item["image_URL"],
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                          const Center(
                                            child: SizedBox(
                                              width: 25,
                                              height: 25,
                                              child:
                                              CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Color(0xFF4CAF50),
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.error, color: Colors.grey),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              LocalizationHelper
                                                  .localizedProductField(
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
                                              "\$${item["price"]}",
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

                    const SizedBox(height: 24),

                    // Add to cart button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final cartBloc = context.read<CartBloc>();

                          final existingItem = cartBloc.state.items.firstWhere(
                                (item) => item.id == widget.product["id"],
                            orElse: () => CartItemModel(
                              id: "",
                              imagePath: "",
                              nameEn: "",
                              price: 0,
                              quantity: 0,
                            ),
                          );

                          if (existingItem.id.isNotEmpty) {
                            final difference = quantity - existingItem.quantity;

                            if (difference > 0) {
                              cartBloc.add(
                                AddItemEvent(
                                  CartItemModel(
                                    imagePath: widget.product["image_URL"],
                                    nameEn: widget.product["title_en"],
                                    nameAr: widget.product["title_ar"],
                                    price: widget.product["price"],
                                    id: widget.product["id"],
                                    quantity: difference,
                                  ),
                                ),
                              );
                            } else if (difference < 0) {
                              for (int i = 0; i < difference.abs(); i++) {
                                cartBloc.add(DecreaseQtyEvent(widget.product["id"]));
                              }
                            }
                          } else {
                            cartBloc.add(
                              AddItemEvent(
                                CartItemModel(
                                  imagePath: widget.product["image_URL"],
                                  nameEn: widget.product["title_en"],
                                  nameAr: widget.product["title_ar"],
                                  price: widget.product["price"],
                                  id: widget.product["id"],
                                  quantity: quantity,
                                ),
                              ),
                            );
                          }

                          Fluttertoast.showToast(
                            msg:
                            "${LocalizationHelper.localizedProductField(widget.product, "title", context)} ${loc.addedToCart}",                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          loc.addToCart,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}