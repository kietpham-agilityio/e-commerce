part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object?> get props => const [];
}

class ProductDetailsLoadRequested extends ProductDetailsEvent {
  const ProductDetailsLoadRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
