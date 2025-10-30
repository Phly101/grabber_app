

import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:grabber_app/Services/FireStore/bloc/items_bloc.dart";
import "package:grabber_app/Services/FireStore/firestore_service.dart";
import "package:mocktail/mocktail.dart";

class MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  group("ItemsBloc", () {
    late FirestoreService firestoreService;
    late ItemsBloc itemsBloc;

    setUp(() {
      firestoreService = MockFirestoreService();
      itemsBloc = ItemsBloc(firestoreService);
    });

    tearDown(() {
      itemsBloc.close();
    });

    test("initial state is ItemsInitial", () {
      expect(itemsBloc.state, isA<ItemsInitial>());
    });

    blocTest<ItemsBloc, ItemsState>(
      "emits [ItemsLoading, ItemsLoaded] when LoadItems is added and getItems succeeds",
      build: () {
        when(() => firestoreService.getItems("testCollection")).thenAnswer(
          (_) => Stream.value([
            {"id": "1", "name": "Item 1"},
            {"id": "2", "name": "Item 2"},
          ]),
        );
        return itemsBloc;
      },
      act: (bloc) => bloc.add(const LoadItems("testCollection")),
      expect: () => [
        isA<ItemsLoading>(),
        isA<ItemsLoaded>().having(
          (state) => state.items,
          "items",
          [
            {"id": "1", "name": "Item 1"},
            {"id": "2", "name": "Item 2"},
          ],
        ),
      ],
      verify: (_) {
        verify(() => firestoreService.getItems("testCollection")).called(1);
      },
    );

    blocTest<ItemsBloc, ItemsState>(
      "emits [ItemsLoading, ItemsError] when LoadItems is added and getItems throws an error",
      build: () {
        when(() => firestoreService.getItems("testCollection"))
            .thenThrow(Exception("test error"));
        return itemsBloc;
      },
      act: (bloc) => bloc.add(const LoadItems("testCollection")),
      expect: () => [
        isA<ItemsLoading>(),
        isA<ItemsError>().having(
          (state) => state.message,
          "message",
          "Exception: test error",
        ),
      ],
      verify: (_) {
        verify(() => firestoreService.getItems("testCollection")).called(1);
      },
    );
  });
}