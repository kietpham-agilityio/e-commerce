part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCommentsRequested extends CommentsEvent {
  const LoadCommentsRequested({required this.postId});

  final int postId;

  @override
  List<Object?> get props => [postId];
}

class RefreshCommentsRequested extends CommentsEvent {
  const RefreshCommentsRequested({required this.postId});

  final int postId;

  @override
  List<Object?> get props => [postId];
}

class DebugScenarioRequested extends CommentsEvent {
  const DebugScenarioRequested(this.scenario);

  final DebugToolScenarios scenario;

  @override
  List<Object?> get props => [scenario];
}

enum DebugToolScenarios { success, empty, error, api }
