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
class FilterItems extends ItemsEvent {
  final double minPrice;
  final double maxPrice;
  final List<String> selectedCategories;

  const FilterItems(this.minPrice, this.maxPrice, this.selectedCategories);

  @override
  List<Object?> get props => [minPrice, maxPrice, selectedCategories];
}
