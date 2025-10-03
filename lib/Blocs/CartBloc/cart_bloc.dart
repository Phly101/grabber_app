
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";

import "../../Services/Users/user_services.dart";


part "cart_event.dart";
part "cart_state.dart";

class CartBloc extends Bloc<CartEvent, CartState> {

  final UserServices userServices;

  CartBloc(this.userServices) : super(const CartState()) {

    on<LoadCartEvent>((event, emit) async{
      await emit.forEach<List<CartItemModel>>(
        userServices.getCart(),
        onData: (items) => state.copyWith(items: items)
      );
    });

    on<AddItemEvent>((event, emit) async{

      await userServices.addCart(event.item);

    });

    on<RemoveItemEvent>((event, emit) async{

      await userServices.removeCart(event.name);

    });

    on<IncreaseQtyEvent>((event, emit) async{
      final item = state.items.firstWhere((i) => i.name == event.name);
      final updated = item.copyWith(quantity: item.quantity + 1);
      await userServices.updateCart(updated);
    });

    on<DecreaseQtyEvent>((event, emit) async{
      final item = state.items.firstWhere((i) => i.name == event.name);
      if (item.quantity > 1) {
        final updated = item.copyWith(quantity: item.quantity - 1);
        await userServices.updateCart(updated);
      } else {
        await userServices.removeCart(item.name);
      }
    });
  }
}
