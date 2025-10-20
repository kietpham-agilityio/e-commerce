import 'package:e_commerce_app/domain/entities/category_entity.dart';
import 'package:e_commerce_app/domain/usecases/shop_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc({required ShopUseCase shopUseCase})
    : _shopUseCase = shopUseCase,
      super(ShopState()) {
    on<ShopFetchCategories>(_onFetchCategories);
  }

  final ShopUseCase _shopUseCase;

  Future<void> _onFetchCategories(
    ShopFetchCategories event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(status: ShopStatus.loading));

    try {
      final response = await _shopUseCase.fetchShopCategories();

      emit(state.copyWith(status: ShopStatus.success, categories: response));
    } catch (e) {
      final String message = e.toString();
      emit(state.copyWith(status: ShopStatus.failure, errorMessage: message));
    }
  }
}
