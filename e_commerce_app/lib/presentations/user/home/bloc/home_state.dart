part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.discountProducts = const <EcProduct>[],
    this.newProducts = const <EcProduct>[],
    this.errorMessage,
  });

  final HomeStatus status;
  final List<EcProduct> discountProducts;
  final List<EcProduct> newProducts;
  final String? errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    List<EcProduct>? discountProducts,
    List<EcProduct>? newProducts,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      discountProducts: discountProducts ?? this.discountProducts,
      newProducts: newProducts ?? this.newProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    discountProducts,
    newProducts,
    errorMessage,
  ];
}
