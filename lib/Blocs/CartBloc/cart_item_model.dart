
class CartItemModel {
  final String id;
  final String imagePath;
  final String nameEn;
  final String? nameAr;
  final num price;
  final int quantity;

  CartItemModel( {
    required this.id,
    required this.imagePath,
    required this.nameEn,
     this.nameAr,
    required this.price,
    required this.quantity,
  });

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      imagePath: imagePath,
      nameEn: nameEn,
      nameAr: nameAr,
      price: price,
      quantity: quantity ?? this.quantity, id: id,
    );
  }
  String get name => nameEn;


}
