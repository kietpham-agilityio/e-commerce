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
    on<ProductDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final ProductDetailsUseCase _productDetailsUseCase;
}
