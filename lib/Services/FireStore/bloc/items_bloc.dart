import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import "package:grabber_app/Services/FireStore/firestore_service.dart";

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final FirestoreService firestoreService;

  ItemsBloc(this.firestoreService) : super(ItemsInitial()) {
    on<LoadItems>((event, emit) async {
      emit(ItemsLoading());
      try {
        await emit.forEach<List<Map<String, dynamic>>>(
          firestoreService.getItems(event.collectionName),
          onData: (items) => ItemsLoaded(items),
          onError: (error, _) => ItemsError(error.toString()),
        );
      } catch (e) {
        emit(ItemsError(e.toString()));
      }
    });
  }
}
