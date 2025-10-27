import 'package:e_commerce_app/config/env_config.dart';
import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/di/app_module.dart';
import 'package:e_commerce_app/presentations/shop/bloc/shop_bloc.dart';
import 'package:ec_core/debug_tools/ui/debug_tools_picker.dart';
import 'package:ec_core/fab_debug/ui/fab_debug_button.dart';
import 'package:ec_core/mocked_backend/interceptors/mock_backend_interceptor.dart';
import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late ShopBloc shopBloc;

  @override
  void initState() {
    shopBloc = AppModule.getIt<ShopBloc>()..add(ShopFetchCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final ecTheme = Theme.of(context);
    final ecThemeExt = ecTheme.extension<EcThemeExtension>()!;
    final spacing = ecThemeExt.spacing;

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        final isShopEnabled = appState.flags.enableShopPage ?? false;

        if (!isShopEnabled) {
          return Scaffold(
            appBar: EcAppBar(title: EcHeadlineSmallText(l10n.shopTitle)),
            body: const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: EcBodyLargeText(
                  'The Shop feature is not available for now',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        return BlocProvider(
          create: (context) => shopBloc,
          child: LoaderOverlay(
            child: BlocListener<ShopBloc, ShopState>(
              listener: (context, state) {
                if (state.status == ShopStatus.loading) {
                  context.loaderOverlay.show();
                } else if (state.status == ShopStatus.failure) {
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
                  title: EcHeadlineSmallText(l10n.shopTitle),
                  actions: [
                    IconButton(onPressed: () {}, icon: EcAssets.search()),
                  ],
                ),
                body: CustomScrollView(
                  slivers: [
                    PinnedHeaderSliver(
                      child: Container(
                        color: ecTheme.colorScheme.surfaceDim,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: spacing.xl),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EcElevatedButton(
                                text: l10n.shopViewAllItemsBtn,
                                onPressed: () {},
                              ),
                              SizedBox(height: spacing.xl),
                              EcTitleMediumText(
                                l10n.shopSubtitle,
                                color: ecTheme.colorScheme.surface,
                              ),
                              SizedBox(height: spacing.xl),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<ShopBloc, ShopState>(
                      buildWhen:
                          (previous, current) =>
                              previous.status != current.status ||
                              previous.categories != current.categories,
                      builder: (context, state) {
                        if (state.categories.isEmpty &&
                            state.status == ShopStatus.failure) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: EcTitleMediumText(
                                'No categories found',
                                textAlign: TextAlign.center,
                                color: ecTheme.colorScheme.surface,
                              ),
                            ),
                          );
                        }
                        return SliverList.separated(
                          itemCount: state.categories.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final item = state.categories[index];
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: spacing.giant,
                              ),
                              title: Text(item.name),
                              onTap: () {
                                // TODO: handle redirect to category page
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                floatingActionButton:
                    EnvConfig.isDebugModeEnabled
                        ? FabDebugButton(
                          onSelectedMockBackend: (scenario) {
                            if (ApiShop.values.contains(scenario.payload)) {
                              shopBloc.add(
                                ShopFetchCategories(isRefetched: true),
                              );
                            }
                          },
                          debugToolsScenarios: [
                            DebugToolsItem(
                              name: 'Success Scenario',
                              onTap: () {
                                shopBloc.add(
                                  const DebugScenarioRequested(
                                    DebugToolScenarios.success,
                                  ),
                                );
                              },
                            ),
                            DebugToolsItem(
                              name: 'Error Scenario',
                              onTap: () {
                                shopBloc.add(
                                  const DebugScenarioRequested(
                                    DebugToolScenarios.error,
                                  ),
                                );
                              },
                            ),
                            DebugToolsItem(
                              name: 'Api Scenario',
                              onTap: () {
                                shopBloc.add(
                                  const DebugScenarioRequested(
                                    DebugToolScenarios.api,
                                  ),
                                );
                              },
                            ),
                          ],

                          enableMockBackend: true,
                        )
                        : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
