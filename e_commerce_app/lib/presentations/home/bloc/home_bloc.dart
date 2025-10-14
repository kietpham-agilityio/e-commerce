import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/usecases/home_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required HomeUseCase homeUseCase})
    : _homeUseCase = homeUseCase,
      super(const HomeState()) {
    on<HomeLoadRequested>(_onLoadRequested);
    on<HomeRefreshRequested>(_onRefreshRequested);
    on<DebugScenarioRequested>(_onDebugScenarioRequested);
  }

  final HomeUseCase _homeUseCase;

  Future<void> _onLoadRequested(
    HomeLoadRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final response = await _homeUseCase.fetchHomeData();

      emit(
        state.copyWith(
          status: HomeStatus.success,
          newProducts: response.newProducts,
          discountProducts: response.discountProducts,
        ),
      );
    } catch (e) {
      final String message = e.toString();
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: message));
    }
  }

  Future<void> _onRefreshRequested(
    HomeRefreshRequested event,
    Emitter<HomeState> emit,
  ) async {
    add(const HomeLoadRequested());
  }

  Future<void> _onDebugScenarioRequested(
    DebugScenarioRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    // switch (event.scenario) {
    //   case DebugToolScenarios.success:
    //     final mockItems = EcMockedData.generateMockItems(5);

    //     emit(state.copyWith(status: HomeStatus.success, items: mockItems));
    //     break;
    //   case DebugToolScenarios.empty:
    //     emit(state.copyWith(status: HomeStatus.success, items: <dynamic>[]));
    //     break;
    //   case DebugToolScenarios.error:
    //     emit(
    //       state.copyWith(
    //         status: HomeStatus.failure,
    //         errorMessage: 'Debug scenario: Simulated error occurred',
    //       ),
    //     );
    //     break;
    //   default:
    //     // Fallback to normal load
    //     add(const LoadRequested());
    // }
  }
}
