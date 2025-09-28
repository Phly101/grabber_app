part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItemModel> items;
  const CartState({this.items = const []});

  CartState copyWith({List<CartItemModel>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object> get props => [items];
}
