import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";
import "package:grabber_app/Services/Users/user_services.dart";
import "package:mockito/mockito.dart";

class MockUserServices extends Mock implements UserServices {
  @override
  Stream<List<CartItemModel>> getCart() {
    return Stream.value([]);
  }

  @override
  Future<void> addCart(CartItemModel item) async {}

  @override
  Future<void> updateCart(CartItemModel item) async {}

  @override
  Future<void> removeCartItem(String id) async {}

  @override
  Future<void> clearUserCart(String userId) async {}
}