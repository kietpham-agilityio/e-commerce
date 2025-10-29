import 'package:e_commerce_app/data/mocks/items_mock.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc({required this.apiClient}) : super(const ItemsState()) {
    on<LoadRequested>(_onLoadRequested);
    on<RefreshRequested>(_onRefreshRequested);
    on<DebugScenarioRequested>(_onDebugScenarioRequested);
  }

  final ApiClient apiClient;

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<ItemsState> emit,
  ) async {
    emit(state.copyWith(status: ItemsStatus.loading, errorMessage: null));

    try {
      final dynamic response = await apiClient.ecommerceApi.getApis();
      final List<dynamic> items = response is List ? response : <dynamic>[];
      emit(state.copyWith(status: ItemsStatus.success, items: items));
    } catch (e) {
      final String message = e.toString();
      emit(state.copyWith(status: ItemsStatus.failure, errorMessage: message));
    }
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<ItemsState> emit,
  ) async {
    add(const LoadRequested());
  }

  Future<void> _onDebugScenarioRequested(
    DebugScenarioRequested event,
    Emitter<ItemsState> emit,
  ) async {
    emit(state.copyWith(status: ItemsStatus.loading));

    switch (event.scenario) {
      case DebugToolScenarios.success:
        final mockItems = EcMockedData.generateMockItems(5);

        emit(state.copyWith(status: ItemsStatus.success, items: mockItems));
        break;
      case DebugToolScenarios.empty:
        emit(state.copyWith(status: ItemsStatus.success, items: <dynamic>[]));
        break;
      case DebugToolScenarios.error:
        emit(
          state.copyWith(
            status: ItemsStatus.failure,
            errorMessage: 'Debug scenario: Simulated error occurred',
          ),
        );
        break;
      default:
        // Fallback to normal load
        add(const LoadRequested());
    }
  }
}
