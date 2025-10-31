import 'package:e_commerce_app/config/env_config.dart';
import 'package:e_commerce_app/core/bloc/debug_bloc.dart';
import 'package:e_commerce_app/core/di/app_module.dart';
import 'package:e_commerce_app/core/utils/context_extension.dart';
import 'package:e_commerce_app/domain/usecases/shop_usecase.dart';
import 'package:e_commerce_app/presentations/user/shop/bloc/shop_bloc.dart';
import 'package:ec_core/debug_tools/ui/debug_tools_picker.dart';
import 'package:ec_core/fab_debug/ui/fab_debug_button.dart';
import 'package:ec_core/mocked_backend/interceptors/mock_backend_interceptor.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ecTheme = context.ecTheme;
    final ecThemeExt = context.ecThemeExt;
    final spacing = ecThemeExt.spacing;

    final appState = context.watch<DebugBloc>().state;
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
      create:
          (context) =>
              ShopBloc(shopUseCase: AppModule.getIt<ShopUseCase>())
                ..add(const ShopFetchCategories()),
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
              actions: [IconButton(onPressed: () {}, icon: EcAssets.search())],
            ),
            body: CustomScrollView(
              slivers: [
                PinnedHeaderSliver(
                  child: Container(
                    color: ecTheme.colorScheme.surface,
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
                            color: ecTheme.colorScheme.outline,
                          ),
                          SizedBox(height: spacing.xl),
                        ],
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    final shopState = context.select(
                      (ShopBloc bloc) => (
                        bloc.state.status,
                        bloc.state.categories,
                      ),
                    );

                    if (shopState.$1 == ShopStatus.failure &&
                        shopState.$2.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: EcTitleMediumText(
                            'No categories found',
                            textAlign: TextAlign.center,
                            color: ecTheme.colorScheme.outline,
                          ),
                        ),
                      );
                    }
                    return SliverList.separated(
                      itemCount: shopState.$2.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        final item = shopState.$2[index];
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
                        final bloc = context.read<ShopBloc>();
                        if (ApiShop.values.contains(scenario.payload)) {
                          bloc.add(
                            const ShopFetchCategories(isRefetched: true),
                          );
                        }
                      },
                      debugToolsScenarios: [
                        DebugToolsItem(
                          name: 'Success Scenario',
                          onTap: () {
                            context.read<ShopBloc>().add(
                              const DebugScenarioRequested(
                                DebugToolScenarios.success,
                              ),
                            );
                          },
                        ),
                        DebugToolsItem(
                          name: 'Error Scenario',
                          onTap: () {
                            context.read<ShopBloc>().add(
                              const DebugScenarioRequested(
                                DebugToolScenarios.error,
                              ),
                            );
                          },
                        ),
                        DebugToolsItem(
                          name: 'Api Scenario',
                          onTap: () {
                            context.read<ShopBloc>().add(
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
  }
}
