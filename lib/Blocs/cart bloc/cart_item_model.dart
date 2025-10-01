class CartItemModel {
  final String imagePath;
  final String name;
  final double price;
  final int quantity;

  CartItemModel({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.quantity,
  });

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      imagePath: imagePath,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}
