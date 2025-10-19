import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final ecTheme = Theme.of(context);
    final ecThemeExt = ecTheme.extension<EcThemeExtension>()!;
    final spacing = ecThemeExt.spacing;

    return Scaffold(
      appBar: EcAppBar(
        title: EcHeadlineSmallText(l10n.shopTitle),
        actions: [IconButton(onPressed: () {}, icon: EcAssets.search())],
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
          SliverList.separated(
            itemCount: 20,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: spacing.giant),
                title: Text('$index'),
                onTap: () {
                  // TODO: handle redirect to category page
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
