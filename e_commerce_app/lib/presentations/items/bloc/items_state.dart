part of 'items_bloc.dart';

enum ItemsStatus { initial, loading, success, failure }

class ItemsState extends Equatable {
  const ItemsState({
    this.status = ItemsStatus.initial,
    this.items = const <dynamic>[],
    this.errorMessage,
  });

  final ItemsStatus status;
  final List<dynamic> items;
  final String? errorMessage;

  ItemsState copyWith({
    ItemsStatus? status,
    List<dynamic>? items,
    String? errorMessage,
  }) {
    return ItemsState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, items, errorMessage];
}
