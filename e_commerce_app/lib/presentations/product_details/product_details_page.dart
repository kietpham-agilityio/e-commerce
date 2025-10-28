import 'dart:developer';

import 'package:e_commerce_app/config/env_config.dart';
import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/di/app_module.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/domain/usecases/product_details_usecase.dart';
import 'package:e_commerce_app/presentations/product_details/bloc/product_details_bloc.dart';
import 'package:ec_core/debug_tools/ui/debug_tools_picker.dart';
import 'package:ec_core/fab_debug/ui/fab_debug_button.dart';
import 'package:ec_core/mocked_backend/interceptors/mock_backend_interceptor.dart';
import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/widgets/card/product_card_in_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
    required this.categoryId,
  });

  final String productId;
  final String categoryId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    // AppModule.getIt<ProductDetailsBloc>()..add(
    //   ProductDetailsLoadRequested(
    //     productId: widget.productId,
    //     categoryId: widget.categoryId,
    //   ),
    // );
    super.initState();
  }

  @override
  void dispose() {
    log('🔴 ProductDetailsPage is being disposed');
    // _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final ecThemeExt = ecTheme.extension<EcThemeExtension>()!;
    final spacing = ecThemeExt.spacing;
    final l10n = AppLocale.of(context)!;

    return BlocProvider(
      create:
          (context) => ProductDetailsBloc(
            productDetailsUseCase: AppModule.getIt<ProductDetailsUseCase>(),
          )..add(
            ProductDetailsLoadRequested(
              productId: widget.productId,
              categoryId: widget.categoryId,
            ),
          ),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          final isProductDetailsEnabled =
              appState.flags.enableProductDetailsPage ?? false;

          if (!isProductDetailsEnabled) {
            return Scaffold(
              appBar: EcAppBar(
                title: EcHeadlineSmallText(l10n.productDetailsTitle),
              ),
              body: const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: EcBodyLargeText(
                    'The Product Details feature is not available for now',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }

          return LoaderOverlay(
            child: BlocListener<ProductDetailsBloc, ProductDetailsState>(
              listener: (context, state) {
                if (state.status == ProductDetailsStatus.loading) {
                  context.loaderOverlay.show();
                } else if (state.status == ProductDetailsStatus.failure) {
                  context.loaderOverlay.hide();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                } else {
                  context.loaderOverlay.hide();
                }
              },
              child: Scaffold(
                appBar: EcAppBar(
                  title: EcHeadlineSmallText(l10n.productDetailsTitle),
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.xl,
                    vertical: spacing.xxxl,
                  ),
                  decoration: BoxDecoration(
                    color: ecTheme.colorScheme.onSecondary,
                    boxShadow: [
                      EcShadows.customShadow(
                        context,
                        offset: Offset(0, -4),
                        blurRadius: 8,
                        opacity: 0.1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EcElevatedButton(
                        text: l10n.productDetailsAddToCartBtn,
                        onPressed: () {
                          // TODO: handle add to cart
                          log('ADD ITEM TO CART');
                        },
                      ),
                      SizedBox(height: spacing.massive),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                        builder: (context, state) {
                          return _ImageCarousel(
                            images: state.products?.imageUrl ?? [],
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spacing.xl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Container(),
                                  EcIconButton(
                                    icon: EcAssets.heart(),
                                    backgroundColor:
                                        ecTheme.colorScheme.onSecondary,
                                    showShadow: true,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spacing.huge),
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<
                                    ProductDetailsBloc,
                                    ProductDetailsState
                                  >(
                                    builder: (context, state) {
                                      return EcHeadlineLargeText(
                                        state.products?.brand ?? '',
                                        height: EcTypography.tightHeight,
                                      );
                                    },
                                  ),
                                  BlocBuilder<
                                    ProductDetailsBloc,
                                    ProductDetailsState
                                  >(
                                    builder: (context, state) {
                                      return EcHeadlineLargeText(
                                        '\$${state.products?.price ?? 0}',
                                        height: EcTypography.tightHeight,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<
                              ProductDetailsBloc,
                              ProductDetailsState
                            >(
                              builder: (context, state) {
                                return EcLabelSmallText(
                                  state.products?.name ?? '',
                                  color: ecTheme.colorScheme.surface,
                                  fontWeight: EcTypography.regular,
                                );
                              },
                            ),
                            SizedBox(height: spacing.sm),
                            EcRatingStarsView(rating: 5, totalReviews: 10),
                            SizedBox(height: spacing.xl),
                            BlocBuilder<
                              ProductDetailsBloc,
                              ProductDetailsState
                            >(
                              builder: (context, state) {
                                return EcBodyMediumText(
                                  state.products?.description ?? '',
                                  maxLines: 10,
                                );
                              },
                            ),
                            SizedBox(height: spacing.xl),
                            Divider(height: 0, thickness: 0),
                            ListTile(
                              title: EcBodyLargeText(l10n.generalShippingInfo),
                              trailing: EcAssets.arrowRight(),
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                // TODO: handle shipping info
                              },
                            ),
                            Divider(height: 0, thickness: 0),
                            ListTile(
                              title: EcBodyLargeText(l10n.supportTitle),
                              trailing: EcAssets.arrowRight(),
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                // TODO: handle support
                              },
                            ),
                            Divider(height: 0, thickness: 0),
                            SizedBox(height: spacing.huge),
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  EcHeadlineSmallText(
                                    l10n.generalYouCanAlsoLikeThis,
                                    height: EcTypography.tightHeight,
                                  ),
                                  BlocBuilder<
                                    ProductDetailsBloc,
                                    ProductDetailsState
                                  >(
                                    buildWhen:
                                        (previous, current) =>
                                            previous.relatedProducts.length !=
                                            current.relatedProducts.length,
                                    builder: (context, state) {
                                      return EcLabelSmallText(
                                        l10n.generalTotalItem(
                                          state.relatedProducts.length,
                                        ),
                                        fontWeight: EcTypography.regular,
                                        color: ecTheme.colorScheme.surface,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spacing.huge),
                      SizedBox(
                        height: MediaQuery.of(context).textScaler.scale(269),
                        child: BlocBuilder<
                          ProductDetailsBloc,
                          ProductDetailsState
                        >(
                          builder: (context, state) {
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.relatedProducts.length,
                              padding: EdgeInsets.symmetric(
                                horizontal: spacing.xl,
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(width: spacing.md),
                              itemBuilder: (context, index) {
                                final item = state.relatedProducts[index];

                                return EcProductCardInMain(
                                  title: item.name,
                                  brand: item.brand,
                                  imageUrl: item.imageUrl.first,
                                  isSoldOut: item.quantity == 0,
                                  originalPrice: item.price.priceFormatter(),
                                  discountedPrice:
                                      item.finalPrice?.priceFormatter(),
                                  labelText: item.label,
                                  onTap: () {
                                    context.pushNamed(
                                      UserAppPaths.productDetails.name,
                                      queryParameters: {
                                        "productId": "${item.id}",
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: spacing.massive),
                    ],
                  ),
                ),
                floatingActionButton: BlocConsumer<AppBloc, AppState>(
                  listener: (context, state) {
                    // Navigate back to first route when Database Inspector is turned off
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  builder: (context, state) {
                    return EnvConfig.isDebugModeEnabled
                        ? FabDebugButton(
                          onSelectedMockBackend: (scenario) {
                            if (MockFeatureProductDetails.values.contains(
                              scenario.payload,
                            )) {
                              context.read<ProductDetailsBloc>().add(
                                ProductDetailsLoadRequested(
                                  productId: widget.productId,
                                  categoryId: widget.categoryId,
                                ),
                              );
                            }
                          },
                          debugToolsScenarios: [
                            DebugToolsItem(
                              name: 'Success Scenario',
                              onTap: () {
                                context.read<ProductDetailsBloc>().add(
                                  const DebugScenarioRequested(
                                    scenario: DebugToolScenarios.success,
                                  ),
                                );
                              },
                            ),
                            DebugToolsItem(
                              name: 'Error Scenario',
                              onTap: () {
                                context.read<ProductDetailsBloc>().add(
                                  const DebugScenarioRequested(
                                    scenario: DebugToolScenarios.error,
                                  ),
                                );
                              },
                            ),
                            DebugToolsItem(
                              name: 'Api Scenario',
                              onTap: () {
                                context.read<ProductDetailsBloc>().add(
                                  DebugScenarioRequested(
                                    scenario: DebugToolScenarios.api,
                                    productId: widget.productId,
                                    categoryId: widget.categoryId,
                                  ),
                                );
                              },
                            ),
                          ],

                          enableMockBackend: true,
                        )
                        : SizedBox.shrink();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ImageCarousel extends StatefulWidget {
  const _ImageCarousel({required this.images});

  final List<String> images;

  @override
  State<_ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<_ImageCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.8);

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth / widget.images.length;
    final ecTheme = Theme.of(context);

    _controller.addListener(() {
      final page = _controller.page?.round() ?? 0;
      if (_currentIndex.value != page) _currentIndex.value = page;
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 413,
          child: PageView.builder(
            padEnds: false,
            controller: _controller,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (_) => _ImageGalleryPage(
                            imageUrls: widget.images,
                            initialIndex: index,
                          ),
                    ),
                  );
                },
                child: Hero(
                  tag: widget.images[index],
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index == (widget.images.length - 1) ? 0 : 4,
                    ),
                    child: EcCachedNetworkImage(
                      url: widget.images[index],
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, currentIndex, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                bool isActive = index == currentIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 4,
                  width: itemWidth,
                  decoration: BoxDecoration(
                    color:
                        isActive
                            ? ecTheme.colorScheme.secondary
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}

class _ImageGalleryPage extends StatefulWidget {
  const _ImageGalleryPage({required this.imageUrls, this.initialIndex = 0});

  final List<String> imageUrls;
  final int initialIndex;

  @override
  State<_ImageGalleryPage> createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<_ImageGalleryPage> {
  late final PageController _pageController;
  late final ValueNotifier<int> _currentIndexNotifier;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentIndexNotifier = ValueNotifier<int>(widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final ecTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: ecTheme.colorScheme.secondary,
      appBar: EcAppBar(
        backgroundColor: ecTheme.colorScheme.secondary,
        leading: EcIconButton(
          backgroundColor: ecTheme.colorScheme.secondary,
          icon: EcAssets.arrowLeft(color: ecTheme.colorScheme.onSecondary),
          onPressed: () {
            context.pop();
          },
        ),
        title: ValueListenableBuilder<int>(
          valueListenable: _currentIndexNotifier,
          builder: (context, index, _) {
            return EcHeadlineSmallText(
              l10n.generalCurrentOfTotal(index + 1, widget.imageUrls.length),
              color: ecTheme.colorScheme.onSecondary,
            );
          },
        ),
      ),
      body: PhotoViewGallery.builder(
        pageController: _pageController,
        itemCount: widget.imageUrls.length,
        backgroundDecoration: BoxDecoration(
          color: ecTheme.colorScheme.secondary,
        ),
        builder: (context, index) {
          final url = widget.imageUrls[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(url),
            heroAttributes: PhotoViewHeroAttributes(tag: url),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
          );
        },
        onPageChanged: (index) {
          _currentIndexNotifier.value = index;
        },
        scrollPhysics: const ClampingScrollPhysics(),
        loadingBuilder:
            (context, event) =>
                const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
