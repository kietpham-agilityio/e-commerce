import 'dart:developer';

import 'package:e_commerce_app/config/env_config.dart';
import 'package:e_commerce_app/core/bloc/debug_bloc.dart';
import 'package:e_commerce_app/core/di/app_module.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/utils/context_extension.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/domain/usecases/home_usecase.dart';
import 'package:e_commerce_app/presentations/user/home/bloc/home_bloc.dart';
import 'package:e_commerce_app/presentations/user/pages/api_client_example.dart';
import 'package:e_commerce_app/presentations/user/pages/example_pages_navigation.dart';
import 'package:e_commerce_app/presentations/user/pages/feature_flag_debug_panel.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:ec_themes/themes/widgets/card/product_card_in_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ecThemeExt = context.ecThemeExt;
    final spacing = ecThemeExt.spacing;

    return BlocProvider(
      create:
          (context) =>
              HomeBloc(homeUseCase: AppModule.getIt<HomeUseCase>())
                ..add(const HomeLoadRequested()),
      child: LoaderOverlay(
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.status == HomeStatus.loading) {
              context.loaderOverlay.show();
            } else if (state.status == HomeStatus.failure) {
              context.loaderOverlay.hide();
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
            } else {
              context.loaderOverlay.hide();
            }
          },
          child: _HomeBody(l10n: l10n, spacing: spacing),
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.l10n, required this.spacing});

  final AppLocale l10n;
  final AppSpacing spacing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(const HomeLoadRequested());
        },
        child: CustomScrollView(
          slivers: [
            EcSliverAppBar(
              title: l10n.homeTitle,
              maxHeight: 196,
              expandedPaddingBottom: 26,
              background: EcCachedNetworkImage(
                url:
                    'https://i.guim.co.uk/img/media/1cc4877b9591dd8b9cc783722fd97b00b87ee162/0_143_6016_3610/master/6016.jpg?width=465&dpr=1&s=none&crop=none',
                width: double.infinity,
                boxFit: BoxFit.cover,
                height: 250,
              ),
            ),
            SliverSafeArea(
              top: false,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: spacing.huge),
                  _CategoryHeader(
                    title: l10n.generalSale,
                    onViewAll: () {
                      // TODO: handle redirect sale page
                      log('onViewall sale');
                    },
                  ),
                  SizedBox(height: spacing.xxl),
                  _ProductHorizontalList(
                    height: MediaQuery.of(context).textScaler.scale(269),
                    isDiscountSection: true,
                    spacing: spacing,
                  ),
                  SizedBox(height: spacing.giant),
                  _CategoryHeader(
                    title: l10n.generalNew,
                    onViewAll: () {
                      // TODO: handle redirect sale page
                      log('onViewall New');
                    },
                  ),
                  SizedBox(height: spacing.xxl),
                  _ProductHorizontalList(
                    height: MediaQuery.of(context).textScaler.scale(269),
                    isDiscountSection: false,
                    spacing: spacing,
                  ),
                  SizedBox(height: spacing.huge),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _DebugButton(),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.title, this.onViewAll});

  final String title;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ecThemeExt = context.ecThemeExt;
    final spacing = ecThemeExt.spacing;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.xl),
      child: IntrinsicWidth(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            EcDisplayMediumText(title),
            GestureDetector(
              onTap: onViewAll,
              child: EcLabelSmallText(l10n.generalViewAll),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductHorizontalList extends StatelessWidget {
  const _ProductHorizontalList({
    required this.height,
    required this.isDiscountSection,
    required this.spacing,
  });

  final double height;
  final bool isDiscountSection;
  final AppSpacing spacing;

  @override
  Widget build(BuildContext context) {
    final state = context.select<HomeBloc, HomeState>((bloc) => bloc.state);
    final products =
        isDiscountSection ? state.discountProducts : state.newProducts;

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: spacing.xl),
        itemCount: products.length,
        separatorBuilder: (_, __) => SizedBox(width: spacing.xl),
        itemBuilder: (context, index) {
          final item = products[index];

          return EcProductCardInMain(
            title: item.name,
            brand: item.brand,
            imageUrl: item.imageUrl.first,
            isSoldOut: item.quantity == 0,
            originalPrice: item.price.priceFormatter(),
            discountedPrice:
                isDiscountSection ? item.finalPrice?.priceFormatter() : null,
            labelText: isDiscountSection ? '-${item.label}' : item.label,
            onTap: () {
              context.pushNamed(
                UserAppPaths.productDetails.name,
                queryParameters: {
                  "productId": "${item.id}",
                  "categoryId": "${item.categoryId}",
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _DebugButton extends StatelessWidget {
  const _DebugButton();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DebugBloc, DebugState>(
      listener: (context, state) {
        // Navigate back to first route when Database Inspector is turned off
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      builder: (context, state) {
        return EnvConfig.isDebugModeEnabled
            ? FabDebugButton(
              onSelectedMockBackend: (scenario) {
                final bloc = context.read<HomeBloc>();
                if (ApiHome.values.contains(scenario.payload)) {
                  bloc.add(const HomeLoadRequested());
                }
              },
              debugToolsScenarios: [
                DebugToolsItem(
                  name: 'Success Scenario',
                  onTap: () {
                    context.read<HomeBloc>().add(
                      const DebugScenarioRequested(DebugToolScenarios.success),
                    );
                  },
                ),
                DebugToolsItem(
                  name: 'Error Scenario',
                  onTap: () {
                    context.read<HomeBloc>().add(
                      const DebugScenarioRequested(DebugToolScenarios.error),
                    );
                  },
                ),
                DebugToolsItem(
                  name: 'Api Scenario',
                  onTap: () {
                    context.read<HomeBloc>().add(
                      const DebugScenarioRequested(DebugToolScenarios.api),
                    );
                  },
                ),
              ],
              onFeatureFlags: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FeatureFlagDebugPanel(),
                  ),
                );
              },
              onApiClientExample: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ApiClientExample(),
                  ),
                );
              },
              onExamplePages: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ExamplePagesNavigation(),
                  ),
                );
              },
              enableMockBackend: true,
            )
            : const SizedBox.shrink();
      },
    );
  }
}
