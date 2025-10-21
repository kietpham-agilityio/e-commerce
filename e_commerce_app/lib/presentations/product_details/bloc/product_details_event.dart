part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object?> get props => const [];
}

class ProductDetailsLoadRequested extends ProductDetailsEvent {
  const ProductDetailsLoadRequested({
    required this.productId,
    required this.categoryId,
  });

  final String productId;
  final String categoryId;

  @override
  List<Object?> get props => [productId, categoryId];
}
