part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => const [];
}

class HomeLoadRequested extends HomeEvent {
  const HomeLoadRequested();
}

class HomeRefreshRequested extends HomeEvent {
  const HomeRefreshRequested();
}

class DebugScenarioRequested extends HomeEvent {
  const DebugScenarioRequested(this.scenario);

  final DebugToolScenarios scenario;

  @override
  List<Object?> get props => [scenario];
}

enum DebugToolScenarios { success, empty, error, api }
