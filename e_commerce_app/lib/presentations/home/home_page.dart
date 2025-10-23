import 'dart:async';
import 'dart:developer';

import 'package:e_commerce_app/config/env_config.dart';
import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/di/app_module.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/presentations/home/bloc/home_bloc.dart';
import 'package:e_commerce_app/presentations/pages/api_client_example.dart';
import 'package:e_commerce_app/presentations/pages/example_pages_navigation.dart';
import 'package:e_commerce_app/presentations/pages/feature_flag_debug_panel.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_core/mocked_backend/core/enum_migration_helper.dart';
import 'package:ec_core/mocked_backend/core/mock_scenario_types.dart';
import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/widgets/card/product_card_in_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = AppModule.getIt<HomeBloc>()..add(HomeLoadRequested());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final ecTheme = Theme.of(context);
    final ecThemeExt = ecTheme.extension<EcThemeExtension>()!;
    final spacing = ecThemeExt.spacing;

    return BlocProvider(
      create: (_) => homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, appState) {
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  final completer = Completer<void>();
                  homeBloc.add(HomeRefreshRequested(completer));
                  return completer.future;
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
                            onViewall: () {
                              // TODO: handle redirect sale page
                              log('onViewall sale');
                            },
                          ),
                          SizedBox(height: spacing.xxl),
                          SizedBox(
                            height: MediaQuery.of(
                              context,
                            ).textScaler.scale(269),
                            child: BlocBuilder<HomeBloc, HomeState>(
                              buildWhen:
                                  (previous, current) =>
                                      previous.discountProducts !=
                                      current.discountProducts,
                              builder: (context, state) {
                                if (state.status != HomeStatus.success) {
                                  return SizedBox();
                                }

                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spacing.xl,
                                  ),
                                  itemCount: state.discountProducts.length,
                                  separatorBuilder:
                                      (_, __) => SizedBox(width: spacing.xl),
                                  itemBuilder: (context, index) {
                                    final item = state.discountProducts[index];

                                    return EcProductCardInMain(
                                      title: item.name,
                                      brand: item.brand,
                                      imageUrl: item.imageUrl.first,
                                      isSoldOut: item.quantity == 0,
                                      originalPrice:
                                          item.price.priceFormatter(),
                                      discountedPrice:
                                          item.finalPrice?.priceFormatter(),
                                      labelText: '-${item.label}',
                                      onTap: () {
                                        context.pushNamed(
                                          AppPaths.productDetails.name,
                                          queryParameters: {
                                            "productId": "${item.id}",
                                            "categoryId": "${item.categoryId}",
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: spacing.giant),
                          _CategoryHeader(
                            title: l10n.generalNew,
                            onViewall: () {
                              // TODO: handle redirect sale page
                              log('onViewall New');
                            },
                          ),
                          SizedBox(height: spacing.xxl),
                          SizedBox(
                            height: MediaQuery.of(
                              context,
                            ).textScaler.scale(269),
                            child: BlocBuilder<HomeBloc, HomeState>(
                              buildWhen:
                                  (previous, current) =>
                                      previous.newProducts !=
                                      current.newProducts,
                              builder: (context, state) {
                                if (state.status == HomeStatus.initial) {
                                  return SizedBox();
                                }

                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spacing.xl,
                                  ),
                                  itemCount: state.newProducts.length,
                                  separatorBuilder:
                                      (_, __) => SizedBox(width: spacing.xl),
                                  itemBuilder: (context, index) {
                                    final item = state.newProducts[index];

                                    return EcProductCardInMain(
                                      title: item.name,
                                      brand: item.brand,
                                      imageUrl: item.imageUrl.first,
                                      isSoldOut: item.quantity == 0,
                                      originalPrice:
                                          item.price.priceFormatter(),
                                      labelText: item.label,
                                      onTap: () {
                                        context.pushNamed(
                                          AppPaths.productDetails.name,
                                          queryParameters: {
                                            "productId": "${item.id}",
                                            "categoryId": "${item.categoryId}",
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: spacing.huge),
                        ]),
                      ),
                    ),
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
                          final unifiedScenario =
                              EnumMigrationHelper.convertToUnifiedEnum(
                                scenario.payload,
                              );
                          if (ScenarioReloadRegistry.shouldReload(
                            unifiedScenario,
                          )) {
                            homeBloc.add(const HomeLoadRequested());
                          }
                          // if (ApiHome.values.contains(scenario.payload)) {
                          //   homeBloc.add(const HomeLoadRequested());
                          // }
                        },
                        debugToolsScenarios: [
                          DebugToolsItem(
                            name: 'Success Scenario',
                            onTap: () {
                              homeBloc.add(
                                const DebugScenarioRequested(
                                  DebugToolScenarios.success,
                                ),
                              );
                            },
                          ),
                          DebugToolsItem(
                            name: 'Error Scenario',
                            onTap: () {
                              homeBloc.add(
                                const DebugScenarioRequested(
                                  DebugToolScenarios.error,
                                ),
                              );
                            },
                          ),
                          DebugToolsItem(
                            name: 'Api Scenario',
                            onTap: () {
                              homeBloc.add(
                                const DebugScenarioRequested(
                                  DebugToolScenarios.api,
                                ),
                              );
                            },
                          ),
                        ],
                        onFeatureFlags: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => const FeatureFlagDebugPanel(),
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
                              builder:
                                  (context) => const ExamplePagesNavigation(),
                            ),
                          );
                        },

                        enableMockBackend: true,
                      )
                      : SizedBox.shrink();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.title, this.onViewall});

  final String title;
  final VoidCallback? onViewall;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final colorScheme = ecTheme.colorScheme;
    final l10n = AppLocale.of(context)!;
    final ecThemeExt = ecTheme.extension<EcThemeExtension>()!;
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
              onTap: onViewall,
              child: EcLabelSmallText(
                l10n.generalViewAll,
                fontWeight: EcTypography.regular,
                color: colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
