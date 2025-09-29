import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_sizing.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class EcProductCardInBag extends StatelessWidget {
  const EcProductCardInBag({
    required this.title,
    required this.isSoldOut,
    required this.imageUrl,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
    this.onMore,
    super.key,
  });

  final String title;
  final bool isSoldOut;
  final String imageUrl;
  final String color;
  final String size;
  final int price;
  final int quantity;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final colorScheme = ecTheme.colorScheme;
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = AppSpacing(themeExtension.themeType);
    final sizing = AppSizing(themeExtension.themeType);

    return EcCardInList(
      url: imageUrl,
      isSoldOut: isSoldOut,
      content: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spacing.md),
              EcTitleLargeText(
                title,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
              SizedBox(height: spacing.xxs),
              RichText(
                text: TextSpan(
                  style: ecTheme.textTheme.labelSmall?.copyWith(
                    letterSpacing: -1.3,
                    fontWeight: EcTypography.regular,
                    height: 1,
                  ),
                  children: [
                    TextSpan(
                      // FIXME: use l10n
                      text: 'Color: ',
                      style: ecTheme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.surface,
                      ),
                    ),
                    TextSpan(text: color),
                    WidgetSpan(child: SizedBox(width: spacing.md)),
                    TextSpan(
                      // FIXME: use l10n
                      text: 'Size: ',
                      style: ecTheme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.surface,
                      ),
                    ),
                    TextSpan(text: size),
                  ],
                ),
              ),
              SizedBox(height: spacing.lg),
              Row(
                children: [
                  Row(
                    spacing: spacing.xl,
                    children: [
                      EcIconButton(
                        showShadow: true,
                        icon: EcAssets.minor(),
                        onPressed: () {},
                        size: 36,
                        backgroundColor: Colors.white,
                        iconColor: Colors.grey,
                      ),
                      EcBodyMediumText(
                        '$quantity',
                        height: EcTypography.normalHeight,
                      ),
                      EcIconButton(
                        showShadow: true,
                        icon: EcAssets.plus(),
                        onPressed: () {},
                        size: 36,
                        backgroundColor: Colors.white,
                        iconColor: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EcIconButton(
                onPressed: onMore ?? () {},
                icon: const Icon(Icons.more_vert),
                size: 40,
                backgroundColor: Colors.transparent,
                iconColor: Colors.grey,
              ),

              Spacer(),
              EcTitleMediumText('$price\$', height: EcTypography.normalHeight),
              SizedBox(height: spacing.xxxl),
            ],
          ),
        ],
      ),
    );
  }
}
