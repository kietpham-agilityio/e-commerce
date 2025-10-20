part of 'shop_bloc.dart';

enum ShopStatus { initial, loading, success, failure }

class ShopState extends Equatable {
  const ShopState({
    this.status = ShopStatus.initial,
    this.categories = const [],
    this.errorMessage,
  });

  final ShopStatus status;
  final List<EcCategoryEntity> categories;
  final String? errorMessage;

  ShopState copyWith({
    ShopStatus? status,
    List<EcCategoryEntity>? categories,
    String? errorMessage,
  }) {
    return ShopState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categories, errorMessage];
}
