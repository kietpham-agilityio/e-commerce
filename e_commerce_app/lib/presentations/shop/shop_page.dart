import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/bloc/app_state.dart';
import 'package:e_commerce_app/core/di/app_module.dart';
import 'package:e_commerce_app/presentations/shop/bloc/shop_bloc.dart';
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
                      builder: (context, state) {
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
              ),
            ),
          ),
        );
      },
    );
  }
}
