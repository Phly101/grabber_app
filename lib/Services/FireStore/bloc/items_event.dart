part of "items_bloc.dart";

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object?> get props => [];
}

class LoadItems extends ItemsEvent {
  final String collectionName;
  const LoadItems(this.collectionName);

  @override
  List<Object?> get props => [collectionName];
}
