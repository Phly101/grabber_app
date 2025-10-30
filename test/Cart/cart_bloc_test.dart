import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Blocs/CartBloc/cart_bloc.dart";
import "package:grabber_app/Blocs/CartBloc/cart_item_model.dart";
import "package:grabber_app/Services/Users/user_services.dart";
import "package:mocktail/mocktail.dart";

class MockUserServices extends Mock implements UserServices {}
class FakeCartItemModel extends Fake implements CartItemModel {}

void main() {
  late CartBloc cartBloc;
  late MockUserServices mockUserServices;

  setUpAll(() {
    registerFallbackValue(FakeCartItemModel());
  });

  setUp(() {
    mockUserServices = MockUserServices();
    cartBloc = CartBloc(mockUserServices);
  });

  tearDown(() {
    cartBloc.close();
  });

  group("CartBloc Tests", () {
    blocTest<CartBloc, CartState>(
      "emits items from getCart stream when LoadCartEvent added",
      build: () {
        final fakeStream = Stream<List<CartItemModel>>.fromIterable([
          [
            CartItemModel(
              id: "1",
              nameEn: "Apple",
              nameAr: "تفاحة",
              price: 2.5,
              quantity: 2,
              imagePath: "",
            )
          ]
        ]);
        when(() => mockUserServices.getCart()).thenAnswer((_) => fakeStream);
        return cartBloc;
      },
      act: (bloc) => bloc.add(LoadCartEvent()),
      expect: () => [
        isA<CartState>().having((s) => s.items.first.nameEn, "item name", "Apple"),
      ],
    );
    blocTest<CartBloc, CartState>(
      "calls addCart when AddItemEvent with new item",
      build: () {
        when(() => mockUserServices.addCart(any())).thenAnswer((_) async {});
        return cartBloc;
      },
      act: (bloc) => bloc.add(AddItemEvent(
        CartItemModel(
          id: "2",
          nameEn: "Banana",
          nameAr: "موز",
          price: 1.0,
          quantity: 1,
          imagePath: "",
        ),
      )),
      verify: (_) {
        verify(() => mockUserServices.addCart(any())).called(1);
      },
    );
    blocTest<CartBloc, CartState>(
      "calls updateCart when AddItemEvent with existing item",
      build: () {
        when(() => mockUserServices.updateCart(any())).thenAnswer((_) async {});
        final existing = CartItemModel(
          id: "3",
          nameEn: "Orange",
          nameAr: "برتقال",
          price: 3.0,
          quantity: 1,
          imagePath: "",
        );
        cartBloc.emit(CartState(items: [existing]));
        return cartBloc;
      },
      act: (bloc) => bloc.add(AddItemEvent(
        CartItemModel(
          id: "3",
          nameEn: "Orange",
          nameAr: "برتقال",
          price: 3.0,
          quantity: 2,
          imagePath: "",
        ),
      )),
      verify: (_) {
        verify(() => mockUserServices.updateCart(any())).called(1);
      },
    );
    blocTest<CartBloc, CartState>(
      "calls removeCartItem when RemoveItemEvent added",
      build: () {
        when(() => mockUserServices.removeCartItem("4")).thenAnswer((_) async {});
        return cartBloc;
      },
      act: (bloc) => bloc.add(const RemoveItemEvent("4")),
      verify: (_) {
        verify(() => mockUserServices.removeCartItem("4")).called(1);
      },
    );
    blocTest<CartBloc, CartState>(
      "calls updateCart when IncreaseQtyEvent added",
      build: () {
        when(() => mockUserServices.updateCart(any())).thenAnswer((_) async {});
        final item = CartItemModel(
          id: "5",
          nameEn: "Grapes",
          nameAr: "عنب",
          price: 4.0,
          quantity: 2,
          imagePath: "",
        );
        cartBloc.emit(CartState(items: [item]));
        return cartBloc;
      },
      act: (bloc) => bloc.add(const IncreaseQtyEvent("5")),
      verify: (_) {
        verify(() => mockUserServices.updateCart(any())).called(1);
      },
    );
    blocTest<CartBloc, CartState>(
      "calls updateCart when DecreaseQtyEvent reduces quantity > 1",
      build: () {
        when(() => mockUserServices.updateCart(any())).thenAnswer((_) async {});
        final item = CartItemModel(
          id: "6",
          nameEn: "Strawberry",
          nameAr: "فراولة",
          price: 3.5,
          quantity: 2,
          imagePath: "",
        );
        cartBloc.emit(CartState(items: [item]));
        return cartBloc;
      },
      act: (bloc) => bloc.add(const DecreaseQtyEvent("6")),
      verify: (_) {
        verify(() => mockUserServices.updateCart(any())).called(1);
      },
    );
    blocTest<CartBloc, CartState>(
      "calls removeCartItem when DecreaseQtyEvent and quantity == 1",
      build: () {
        when(() => mockUserServices.removeCartItem("7")).thenAnswer((_) async {});
        final item = CartItemModel(
          id: "7",
          nameEn: "Mango",
          nameAr: "مانجو",
          price: 5.0,
          quantity: 1,
          imagePath: "",
        );
        cartBloc.emit(CartState(items: [item]));
        return cartBloc;
      },
      act: (bloc) => bloc.add(const DecreaseQtyEvent("7")),
      verify: (_) {
        verify(() => mockUserServices.removeCartItem("7")).called(1);
      },
    );
    blocTest<CartBloc, CartState>(
      "emits [empty, CartCleared] when ClearUserCart succeeds",
      build: () {
        when(() => mockUserServices.clearUserCart("uid123")).thenAnswer((_) async {});
        final item = CartItemModel(
          id: "8",
          nameEn: "WaterMelon",
          nameAr: "بطيخ",
          price: 2.0,
          quantity: 1,
          imagePath: "",
        );
        cartBloc.emit(CartState(items: [item]));
        return cartBloc;
      },
      act: (bloc) => bloc.add(const ClearUserCart("uid123")),
      expect: () => [
        isA<CartState>().having((s) => s.items.isEmpty, "empty cart", true),
        isA<CartCleared>(),
      ],
    );
    blocTest<CartBloc, CartState>(
      "emits [empty, CartError] when ClearUserCart throws",
      build: () {
        when(() => mockUserServices.clearUserCart("uid404"))
            .thenThrow(Exception("Failed to clear"));
        final item = CartItemModel(
          id: "9",
          nameEn: "Lemon",
          nameAr: "ليمون",
          price: 1.0,
          quantity: 1,
          imagePath: "",
        );
        cartBloc.emit(CartState(items: [item]));
        return cartBloc;
      },
      act: (bloc) => bloc.add(const ClearUserCart("uid404")),
      expect: () => [
        isA<CartState>().having((s) => s.items.isEmpty, "empty cart", true),
        isA<CartError>().having((e) => e.message, "error message", contains("Failed to clear")),
      ],
    );
  });
}