part of "cart_bloc.dart";

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddItemEvent extends CartEvent {
  final CartItemModel item;


  const AddItemEvent(this.item);
}

class RemoveItemEvent extends CartEvent {
  final String id;

  const RemoveItemEvent(this.id);
}

class IncreaseQtyEvent extends CartEvent {
  final String id;

  const IncreaseQtyEvent(this.id);
}

class DecreaseQtyEvent extends CartEvent {
  final String id;

  const DecreaseQtyEvent(this.id);
}
class ClearUserCart extends CartEvent{
  final String userId;
  const ClearUserCart(this.userId);
}
