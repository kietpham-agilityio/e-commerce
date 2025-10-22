import 'package:e_commerce_app/data/mocks/items_mock.dart';
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
    on<DebugScenarioRequested>(_onDebugScenarioRequested);
  }

  final ProductDetailsUseCase _productDetailsUseCase;

  Future<void> _onLoadRequested(
    ProductDetailsLoadRequested event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(state.copyWith(status: ProductDetailsStatus.loading));

    try {
      final response = await _productDetailsUseCase.fetchProductDetails(
        productId: event.productId,
        categoryId: event.categoryId,
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

  Future<void> _onDebugScenarioRequested(
    DebugScenarioRequested event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(state.copyWith(status: ProductDetailsStatus.loading));

    switch (event.scenario) {
      case DebugToolScenarios.success:
        final mockHomeEntities = EcMockedData.generateHomeData();

        emit(
          state.copyWith(
            status: ProductDetailsStatus.success,
            products: mockHomeEntities.newProducts.first,
            relatedProducts: mockHomeEntities.discountProducts,
          ),
        );
        break;
      case DebugToolScenarios.error:
        emit(
          state.copyWith(
            status: ProductDetailsStatus.failure,
            errorMessage: 'Debug scenario: Simulated error occurred',
          ),
        );
        break;
      default:
        // Fallback to normal load
        add(ProductDetailsLoadRequested(productId: '', categoryId: ''));
    }
  }
}
