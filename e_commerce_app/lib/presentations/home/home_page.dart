import 'dart:developer';

import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/bloc/app_state.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/presentations/pages/api_client_example.dart';
import 'package:e_commerce_app/presentations/pages/database_inspector_page.dart';
import 'package:e_commerce_app/presentations/pages/debug_overlay_page.dart';
import 'package:e_commerce_app/presentations/pages/example_pages_navigation.dart';
import 'package:e_commerce_app/presentations/pages/feature_flag_debug_panel.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/widgets/card/product_card_in_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final ecTheme = Theme.of(context);
    final ecThemeExt = ecTheme.extension<EcThemeExtension>()!;
    final spacing = ecThemeExt.spacing;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: handle pull to refresh
          await Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: [
            EcSliverAppBar(
              title: l10n.homeTitle,
              maxHeight: 196,
              expandedPaddingBottom: 26,
              background: Image.network(
                'https://i.guim.co.uk/img/media/1cc4877b9591dd8b9cc783722fd97b00b87ee162/0_143_6016_3610/master/6016.jpg?width=465&dpr=1&s=none&crop=none',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
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
                    height: MediaQuery.of(context).textScaler.scale(269),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: spacing.xl),
                      itemCount: 10,
                      separatorBuilder: (_, __) => SizedBox(width: spacing.xl),
                      itemBuilder: (context, index) {
                        return EcProductCardInMain(
                          title: 'Pullover',
                          brand: 'Mango',
                          imageUrl:
                              'https://static.vecteezy.com/system/resources/thumbnails/057/068/323/small/single-fresh-red-strawberry-on-table-green-background-food-fruit-sweet-macro-juicy-plant-image-photo.jpg',
                          isSoldOut: false,
                          originalPrice: 51.0.priceFormatter(),
                          discountedPrice: 20.55.priceFormatter(),
                          labelText: '-20%',
                          onTap: () {
                            // TODO: handle redirect product details
                            log('ontap sale $index');
                            context.pushNamed(AppPaths.productDetails.name);
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
                    height: MediaQuery.of(context).textScaler.scale(269),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: spacing.xl),
                      itemCount: 10,
                      separatorBuilder: (_, __) => SizedBox(width: spacing.xl),
                      itemBuilder: (context, index) {
                        return EcProductCardInMain(
                          title: 'Pullover',
                          brand: 'Mango',
                          imageUrl:
                              'https://static.vecteezy.com/system/resources/thumbnails/057/068/323/small/single-fresh-red-strawberry-on-table-green-background-food-fruit-sweet-macro-juicy-plant-image-photo.jpg',
                          isSoldOut: false,
                          originalPrice: 51.0.priceFormatter(),
                          discountedPrice: 20.55.priceFormatter(),
                          labelText: 'NEW',
                          onTap: () {
                            // TODO: handle redirect product details
                            log('ontap new $index');
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
        listenWhen: (previous, current) {
          // Listen when Database Inspector flag changes from true to false
          return previous.flags.enableDatabaseInspector !=
              current.flags.enableDatabaseInspector;
        },
        listener: (context, state) {
          // Navigate back to first route when Database Inspector is turned off
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        builder: (context, state) {
          final flags = state.flags;

          return FabDebugButton(
            key: ValueKey(
              'fab_debug_${flags.enableDatabaseInspector}_${flags.enableDebugOverlay}',
            ),
            onSelectedMockBackend: (scenario) {
              // Handle mock backend scenario selection if needed
            },
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
            // Only enable Database Inspector if feature flag is on
            onDatabaseInspector:
                flags.enableDatabaseInspector == true
                    ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DatabaseInspectorPage(),
                        ),
                      );
                    }
                    : null,
            // Only enable Debug Overlay if feature flag is on
            onDebugOverlay:
                flags.enableDebugOverlay == true
                    ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DebugOverlayPage(),
                        ),
                      );
                    }
                    : null,
            enableMockBackend: false,
          );
        },
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
                color: colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
