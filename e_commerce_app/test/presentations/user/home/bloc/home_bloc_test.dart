import 'package:bloc_test/bloc_test.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:e_commerce_app/domain/entities/home_entities.dart';
import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/usecases/home_usecase.dart';
import 'package:e_commerce_app/presentations/user/home/bloc/home_bloc.dart';

/// Mock class for HomeUseCase
class MockHomeUseCase extends Mock implements HomeUseCase {}

void main() {
  group('HomeBloc', () {
    late MockHomeUseCase mockHomeUseCase;
    late HomeBloc homeBloc;

    final mockHomeData = EcHomeEntities(
      newProducts: [
        EcProduct(id: 1, name: 'Product 1', brand: 'Brand 1', price: 100.0),
        EcProduct(id: 2, name: 'Product 2', brand: 'Brand 2', price: 200.0),
      ],
      discountProducts: [
        EcProduct(
          id: 3,
          name: 'Product 3',
          brand: 'Brand 3',
          price: 150.0,
          discount: 10,
        ),
      ],
    );

    setUp(() {
      mockHomeUseCase = MockHomeUseCase();
      homeBloc = HomeBloc(homeUseCase: mockHomeUseCase);
    });

    tearDown(() {
      homeBloc.close();
    });

    test('initial state is correct', () {
      expect(
        homeBloc.state,
        const HomeState(
          status: HomeStatus.initial,
          discountProducts: <EcProduct>[],
          newProducts: <EcProduct>[],
        ),
      );
    });

    group('HomeLoadRequested', () {
      blocTest<HomeBloc, HomeState>(
        'emits loading then success with products when fetch succeeds',
        build: () {
          when(
            () => mockHomeUseCase.fetchHomeData(),
          ).thenAnswer((_) async => mockHomeData);
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeLoadRequested()),
        expect:
            () => [
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.loading &&
                    state.discountProducts.isEmpty &&
                    state.newProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.success &&
                    state.newProducts.length == 2 &&
                    state.discountProducts.length == 1 &&
                    state.newProducts[0].id == 1 &&
                    state.newProducts[1].id == 2 &&
                    state.discountProducts[0].id == 3 &&
                    state.errorMessage == null,
              ),
            ],
        verify: (_) {
          verify(() => mockHomeUseCase.fetchHomeData()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits loading then success with empty products when fetch returns empty data',
        build: () {
          final emptyHomeData = EcHomeEntities(
            newProducts: const <EcProduct>[],
            discountProducts: const <EcProduct>[],
          );
          when(
            () => mockHomeUseCase.fetchHomeData(),
          ).thenAnswer((_) async => emptyHomeData);
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeLoadRequested()),
        expect:
            () => [
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.loading &&
                    state.discountProducts.isEmpty &&
                    state.newProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.success &&
                    state.newProducts.isEmpty &&
                    state.discountProducts.isEmpty &&
                    state.errorMessage == null,
              ),
            ],
        verify: (_) {
          verify(() => mockHomeUseCase.fetchHomeData()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits loading then failure with error message when fetch throws exception',
        build: () {
          when(
            () => mockHomeUseCase.fetchHomeData(),
          ).thenThrow(Exception('Network error'));
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeLoadRequested()),
        expect:
            () => [
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.loading &&
                    state.discountProducts.isEmpty &&
                    state.newProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.failure &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Exception'),
              ),
            ],
        verify: (_) {
          verify(() => mockHomeUseCase.fetchHomeData()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits loading then failure with error message when fetch throws Failure',
        build: () {
          final failure = Failure('Failed to fetch home data');
          when(() => mockHomeUseCase.fetchHomeData()).thenThrow(failure);
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeLoadRequested()),
        expect:
            () => [
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.loading &&
                    state.discountProducts.isEmpty &&
                    state.newProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.failure &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Failed'),
              ),
            ],
        verify: (_) {
          verify(() => mockHomeUseCase.fetchHomeData()).called(1);
        },
      );
    });

    group('DebugScenarioRequested', () {
      blocTest<HomeBloc, HomeState>(
        'emits loading then success with mock data for success scenario',
        build: () => homeBloc,
        act:
            (bloc) => bloc.add(
              const DebugScenarioRequested(DebugToolScenarios.success),
            ),
        expect:
            () => [
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.loading &&
                    state.discountProducts.isEmpty &&
                    state.newProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.success &&
                    state.newProducts.isNotEmpty &&
                    state.discountProducts.isNotEmpty &&
                    state.errorMessage == null,
              ),
            ],
        verify: (_) {
          verifyNever(() => mockHomeUseCase.fetchHomeData());
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits loading then failure with error message for error scenario',
        build: () => homeBloc,
        act:
            (bloc) => bloc.add(
              const DebugScenarioRequested(DebugToolScenarios.error),
            ),
        expect:
            () => [
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.loading &&
                    state.discountProducts.isEmpty &&
                    state.newProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.failure &&
                    state.errorMessage ==
                        'Debug scenario: Simulated error occurred' &&
                    state.discountProducts.isEmpty &&
                    state.newProducts.isEmpty,
              ),
            ],
        verify: (_) {
          verifyNever(() => mockHomeUseCase.fetchHomeData());
        },
      );

      blocTest<HomeBloc, HomeState>(
        'falls back to normal load for api scenario',
        build: () {
          when(
            () => mockHomeUseCase.fetchHomeData(),
          ).thenAnswer((_) async => mockHomeData);
          return homeBloc;
        },
        act:
            (bloc) =>
                bloc.add(const DebugScenarioRequested(DebugToolScenarios.api)),
        expect:
            () => [
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.loading &&
                    state.discountProducts.isEmpty &&
                    state.newProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<HomeState>(
                (state) =>
                    state.status == HomeStatus.success &&
                    state.newProducts.length == 2 &&
                    state.discountProducts.length == 1 &&
                    state.errorMessage == null,
              ),
            ],
        verify: (_) {
          verify(() => mockHomeUseCase.fetchHomeData()).called(1);
        },
      );
    });
  });
}
