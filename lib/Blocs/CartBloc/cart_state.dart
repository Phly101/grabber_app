part of "cart_bloc.dart";

class CartState extends Equatable {
  final List<CartItemModel> items;
  const CartState({this.items = const []});

  CartState copyWith({List<CartItemModel>? items}) {
    return CartState(items: items ?? this.items);
  }
  int get totalItems =>
      items.fold(0, (sum, item) => sum + item.quantity);
  @override
  List<Object> get props => [items];
}

