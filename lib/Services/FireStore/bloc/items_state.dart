part of 'items_bloc.dart';

sealed class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object?> get props => [];
}

final class ItemsInitial extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<Map<String, dynamic>> items;
  const ItemsLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ItemsError extends ItemsState {
  final String message;
  const ItemsError(this.message);

  @override
  List<Object?> get props => [message];
}
