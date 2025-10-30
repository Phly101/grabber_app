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

  num get totalPrice => items.fold(0, (sum, item) => sum + (item.price*item.quantity));

}
class CartCleared extends CartState {}
class CartError extends CartState {
  final String message;
  const CartError(this.message);
}