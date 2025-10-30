import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:badges/badges.dart" as badges;
import "../../../Blocs/CartBloc/cart_item_model.dart";
import "widgets/imports.dart";

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeQuantity();
    });
  }

  void _initializeQuantity() {
    if (!mounted) return;

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

    if (existingItem.id.isNotEmpty && mounted) {
      setState(() => quantity = existingItem.quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Cart Badge integrated here
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
              ProductImage(
                product: widget.product,
                backgroundColor: backgroundColor,
              ),
              const SizedBox(height: 20),
              ProductInfo(
                product: widget.product,
                quantity: quantity,
                onQuantityChanged: (newQuantity) {
                  if (mounted) {
                    setState(() => quantity = newQuantity);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}