import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";


part "cart_event.dart";
part "cart_state.dart";

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddItemEvent>((event, emit) {
      final existingIndex = state.items.indexWhere(
        (item) => item.name == event.item.name,
      );
      if (existingIndex >= 0) {
        final updated = List<CartItemModel>.from(state.items);
        final current = updated[existingIndex];
        updated[existingIndex] = current.copyWith(
          quantity: current.quantity + event.item.quantity,
        );
        emit(state.copyWith(items: updated));
      } else {
        emit(state.copyWith(items: [...state.items, event.item]));
      }
    });

    on<RemoveItemEvent>(
      (event, emit) {
        emit(
          state.copyWith(
            items: state.items
                .where(
                  (element) => element.name != event.name,
                )
                .toList(),
          ),
        );
      },
    );

    on<IncreaseQtyEvent>((event, emit) {
      final updated = state.items.map((item) {
        if (item.name == event.name) {
          return item.copyWith(quantity: item.quantity + 1);
        }
        return item;
      }).toList();
      emit(state.copyWith(items: updated));
    });

    on<DecreaseQtyEvent>(
      (event, emit) {
        final updated = state.items.map((item) {
          if (item.name == event.name && item.quantity > 1) {
            return item.copyWith(quantity: item.quantity - 1);
          }
          return item;
        }).toList();
        emit(state.copyWith(items: updated));
      },
    );
  }
}
