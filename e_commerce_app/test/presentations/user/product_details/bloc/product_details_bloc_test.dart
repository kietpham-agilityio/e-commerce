import 'package:bloc_test/bloc_test.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/usecases/product_details_usecase.dart';
import 'package:e_commerce_app/presentations/user/product_details/bloc/product_details_bloc.dart';

/// Mock class for ProductDetailsUseCase
class MockProductDetailsUseCase extends Mock
    implements ProductDetailsUseCase {}

void main() {
  group('ProductDetailsBloc', () {
    late MockProductDetailsUseCase mockProductDetailsUseCase;
    late ProductDetailsBloc productDetailsBloc;

    const productId = '123';
    const categoryId = '456';

    final mockProduct = EcProduct(
      id: 1,
      name: 'Test Product',
      brand: 'Test Brand',
      price: 100.0,
      description: 'Test Description',
    );

    final mockRelatedProducts = [
      EcProduct(
        id: 2,
        name: 'Related Product 1',
        brand: 'Test Brand',
        price: 150.0,
      ),
      EcProduct(
        id: 3,
        name: 'Related Product 2',
        brand: 'Test Brand',
        price: 200.0,
      ),
    ];

    final mockProductDetails = EcProductDetails(
      product: mockProduct,
      relatedProducts: mockRelatedProducts,
    );

    setUp(() {
      mockProductDetailsUseCase = MockProductDetailsUseCase();
      productDetailsBloc = ProductDetailsBloc(
        productDetailsUseCase: mockProductDetailsUseCase,
      );
    });

    tearDown(() {
      productDetailsBloc.close();
    });

    test('initial state is correct', () {
      expect(
        productDetailsBloc.state,
        const ProductDetailsState(
          status: ProductDetailsStatus.initial,
          products: null,
          relatedProducts: <EcProduct>[],
        ),
      );
    });

    group('ProductDetailsLoadRequested', () {
      blocTest<ProductDetailsBloc, ProductDetailsState>(
        'emits loading then success with product and related products when fetch succeeds',
        build: () {
          when(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: productId,
              categoryId: categoryId,
            ),
          ).thenAnswer((_) async => mockProductDetails);
          return productDetailsBloc;
        },
        act: (bloc) => bloc.add(
          const ProductDetailsLoadRequested(
            productId: productId,
            categoryId: categoryId,
          ),
        ),
        expect:
            () => [
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.loading &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.success &&
                    state.products != null &&
                    state.products!.id == 1 &&
                    state.products!.name == 'Test Product' &&
                    state.relatedProducts.length == 2 &&
                    state.relatedProducts[0].id == 2 &&
                    state.relatedProducts[1].id == 3 &&
                    state.errorMessage == null,
              ),
            ],
        verify: (_) {
          verify(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: productId,
              categoryId: categoryId,
            ),
          ).called(1);
        },
      );

      blocTest<ProductDetailsBloc, ProductDetailsState>(
        'emits loading then success with empty related products when fetch returns no related products',
        build: () {
          final productDetailsWithNoRelated = EcProductDetails(
            product: mockProduct,
            relatedProducts: const <EcProduct>[],
          );
          when(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: productId,
              categoryId: categoryId,
            ),
          ).thenAnswer((_) async => productDetailsWithNoRelated);
          return productDetailsBloc;
        },
        act: (bloc) => bloc.add(
          const ProductDetailsLoadRequested(
            productId: productId,
            categoryId: categoryId,
          ),
        ),
        expect:
            () => [
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.loading &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.success &&
                    state.products != null &&
                    state.products!.id == 1 &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage == null,
              ),
            ],
        verify: (_) {
          verify(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: productId,
              categoryId: categoryId,
            ),
          ).called(1);
        },
      );

      blocTest<ProductDetailsBloc, ProductDetailsState>(
        'emits loading then failure with error message when fetch throws exception',
        build: () {
          when(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: productId,
              categoryId: categoryId,
            ),
          ).thenThrow(Exception('Network error'));
          return productDetailsBloc;
        },
        act: (bloc) => bloc.add(
          const ProductDetailsLoadRequested(
            productId: productId,
            categoryId: categoryId,
          ),
        ),
        expect:
            () => [
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.loading &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.failure &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Exception'),
              ),
            ],
        verify: (_) {
          verify(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: productId,
              categoryId: categoryId,
            ),
          ).called(1);
        },
      );

      blocTest<ProductDetailsBloc, ProductDetailsState>(
        'emits loading then failure with error message when fetch throws Failure',
        build: () {
          final failure = Failure('Failed to fetch product details');
          when(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: productId,
              categoryId: categoryId,
            ),
          ).thenThrow(failure);
          return productDetailsBloc;
        },
        act: (bloc) => bloc.add(
          const ProductDetailsLoadRequested(
            productId: productId,
            categoryId: categoryId,
          ),
        ),
        expect:
            () => [
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.loading &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.failure &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Failed'),
              ),
            ],
        verify: (_) {
          verify(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: productId,
              categoryId: categoryId,
            ),
          ).called(1);
        },
      );
    });

    group('DebugScenarioRequested', () {
      blocTest<ProductDetailsBloc, ProductDetailsState>(
        'emits loading then success with mock data for success scenario',
        build: () => productDetailsBloc,
        act: (bloc) => bloc.add(
          const DebugScenarioRequested(
            scenario: DebugToolScenarios.success,
          ),
        ),
        expect:
            () => [
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.loading &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.success &&
                    state.products != null &&
                    state.relatedProducts.isNotEmpty &&
                    state.errorMessage == null,
              ),
            ],
        verify: (_) {
          verifyNever(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: any(named: 'productId'),
              categoryId: any(named: 'categoryId'),
            ),
          );
        },
      );

      blocTest<ProductDetailsBloc, ProductDetailsState>(
        'emits loading then failure with error message for error scenario',
        build: () => productDetailsBloc,
        act: (bloc) => bloc.add(
          const DebugScenarioRequested(
            scenario: DebugToolScenarios.error,
          ),
        ),
        expect:
            () => [
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.loading &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.failure &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage == 'Debug scenario: Simulated error occurred',
              ),
            ],
        verify: (_) {
          verifyNever(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: any(named: 'productId'),
              categoryId: any(named: 'categoryId'),
            ),
          );
        },
      );

      blocTest<ProductDetailsBloc, ProductDetailsState>(
        'falls back to normal load for api scenario',
        build: () {
          when(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: '',
              categoryId: '',
            ),
          ).thenAnswer((_) async => mockProductDetails);
          return productDetailsBloc;
        },
        act: (bloc) => bloc.add(
          const DebugScenarioRequested(
            scenario: DebugToolScenarios.api,
          ),
        ),
        expect:
            () => [
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.loading &&
                    state.products == null &&
                    state.relatedProducts.isEmpty &&
                    state.errorMessage == null,
              ),
              predicate<ProductDetailsState>(
                (state) =>
                    state.status == ProductDetailsStatus.success &&
                    state.products != null &&
                    state.products!.id == 1 &&
                    state.relatedProducts.length == 2 &&
                    state.errorMessage == null,
              ),
            ],
        verify: (_) {
          verify(
            () => mockProductDetailsUseCase.fetchProductDetails(
              productId: '',
              categoryId: '',
            ),
          ).called(1);
        },
      );
    });
  });
}

