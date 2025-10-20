part of 'shop_bloc.dart';

class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object?> get props => [];
}

class ShopFetchCategories extends ShopEvent {
  const ShopFetchCategories();

  @override
  List<Object?> get props => [];
}

class DebugScenarioRequested extends ShopEvent {
  const DebugScenarioRequested(this.scenario);

  final DebugToolScenarios scenario;

  @override
  List<Object?> get props => [scenario];
}

enum DebugToolScenarios { success, error, api }
