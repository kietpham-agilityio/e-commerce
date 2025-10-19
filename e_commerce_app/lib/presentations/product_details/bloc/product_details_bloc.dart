import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/usecases/product_details_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc({required ProductDetailsUseCase productDetailsUseCase})
    : _productDetailsUseCase = productDetailsUseCase,
      super(const ProductDetailsState()) {
    on<ProductDetailsLoadRequested>(_onLoadRequested);
  }

  final ProductDetailsUseCase _productDetailsUseCase;

  Future<void> _onLoadRequested(
    ProductDetailsLoadRequested event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(state.copyWith(status: ProductDetailsStatus.loading));

    try {
      final response = await _productDetailsUseCase.fetchProductDetails(
        event.id,
      );

      emit(
        state.copyWith(
          status: ProductDetailsStatus.success,
          products: response.product,
          relatedProducts: response.relatedProducts,
        ),
      );
    } catch (e) {
      final String message = e.toString();
      emit(
        state.copyWith(
          status: ProductDetailsStatus.failure,
          errorMessage: message,
        ),
      );
    }
  }
}
