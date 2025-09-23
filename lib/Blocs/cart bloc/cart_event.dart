part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}
class AddItemEvent extends CartEvent {
  final CartItemModel item;
  const AddItemEvent(this.item);
}

class RemoveItemEvent extends CartEvent {
  final String name;
  const RemoveItemEvent(this.name);
}

class IncreaseQtyEvent extends CartEvent {
  final String name;
  const IncreaseQtyEvent(this.name);
}

class DecreaseQtyEvent extends CartEvent {
  final String name;
  const DecreaseQtyEvent(this.name);
}