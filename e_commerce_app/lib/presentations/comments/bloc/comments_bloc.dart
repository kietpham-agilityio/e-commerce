import 'package:e_commerce_app/data/mocks/items_mock.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required this.apiClient}) : super(const CommentsState()) {
    on<LoadCommentsRequested>(_onLoadCommentsRequested);
    on<RefreshCommentsRequested>(_onRefreshCommentsRequested);
    on<DebugScenarioRequested>(_onDebugScenarioRequested);
  }

  final ApiClient apiClient;

  Future<void> _onLoadCommentsRequested(
    LoadCommentsRequested event,
    Emitter<CommentsState> emit,
  ) async {
    emit(state.copyWith(status: CommentsStatus.loading, postId: event.postId));

    try {
      final dynamic response = await apiClient.testApis.getComments(
        event.postId,
      );
      final List<dynamic> comments = response is List ? response : <dynamic>[];
      emit(state.copyWith(status: CommentsStatus.success, comments: comments));
    } catch (e) {
      final String message = e.toString();
      emit(
        state.copyWith(status: CommentsStatus.failure, errorMessage: message),
      );
    }
  }

  Future<void> _onRefreshCommentsRequested(
    RefreshCommentsRequested event,
    Emitter<CommentsState> emit,
  ) async {
    add(LoadCommentsRequested(postId: event.postId));
  }

  Future<void> _onDebugScenarioRequested(
    DebugScenarioRequested event,
    Emitter<CommentsState> emit,
  ) async {
    final postId = state.postId;
    switch (event.scenario) {
      case DebugToolScenarios.success:
        final mockComments = EcMockedData.generateMockComments(5);

        emit(
          state.copyWith(
            status: CommentsStatus.success,
            comments: mockComments,
          ),
        );
        break;
      case DebugToolScenarios.empty:
        emit(
          state.copyWith(status: CommentsStatus.success, comments: <dynamic>[]),
        );
        break;
      case DebugToolScenarios.error:
        emit(
          state.copyWith(
            status: CommentsStatus.failure,
            errorMessage: 'Debug scenario: Simulated error occurred',
          ),
        );
        break;
      default:
        // Fallback to normal load
        add(RefreshCommentsRequested(postId: postId));
    }
  }
}
