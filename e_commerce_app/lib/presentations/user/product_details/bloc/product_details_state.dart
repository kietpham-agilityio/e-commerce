part of 'product_details_bloc.dart';

enum ProductDetailsStatus { initial, loading, success, failure }

class ProductDetailsState extends Equatable {
  const ProductDetailsState({
    this.products,
    this.status = ProductDetailsStatus.initial,
    this.relatedProducts = const [],
    this.errorMessage,
  });

  final ProductDetailsStatus status;
  final EcProduct? products;
  final List<EcProduct> relatedProducts;
  final String? errorMessage;

  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    EcProduct? products,
    List<EcProduct>? relatedProducts,
    String? errorMessage,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      products: products ?? this.products,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    products,
    status,
    relatedProducts,
    errorMessage,
  ];
}
