part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object?> get props => const [];
}

class LoadRequested extends ItemsEvent {
  const LoadRequested();
}

class RefreshRequested extends ItemsEvent {
  const RefreshRequested();
}

class DebugScenarioRequested extends ItemsEvent {
  const DebugScenarioRequested(this.scenario);

  final DebugToolScenarios scenario;

  @override
  List<Object?> get props => [scenario];
}

enum DebugToolScenarios { success, empty, error, api }
