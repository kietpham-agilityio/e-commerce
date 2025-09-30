import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class EcProductCardInCatalog extends StatelessWidget {
  const EcProductCardInCatalog({
    required this.title,
    this.subtitle = '',
    this.imageUrl = '',
    this.isSoldOut = false,
    this.labelStyle = EcLabelStyle.primary,
    this.rating = 0,
    this.totalReviews = 0,
    this.color,
    this.size,
    this.price,
    this.quantity,
    this.onFavorite,
    super.key,
  });

  final String title;

  final String subtitle;

  final bool isSoldOut;

  final String imageUrl;

  final String? color;

  final String? size;

  final int? price;

  final int? quantity;

  final VoidCallback? onFavorite;

  final EcLabelStyle labelStyle;

  final double rating;

  final int totalReviews;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final colorScheme = ecTheme.colorScheme;
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = AppSpacing(themeExtension.themeType);

    return EcCardInList(
      url: imageUrl,
      isSoldOut: isSoldOut,
      actions: [
        Positioned(
          top: spacing.sm,
          left: spacing.sm,
          child: EcLabel(text: 'NEW', style: labelStyle),
        ),
        Positioned(
          bottom: -10,
          right: 0,
          child: EcIconButton(
            icon: EcAssets.heart(color: colorScheme.surface),
            backgroundColor: colorScheme.primaryContainer,
            showShadow: true,
            onPressed: onFavorite,
          ),
        ),
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: spacing.md),
          EcTitleLargeText(title, fontWeight: EcTypography.bold),
          SizedBox(height: spacing.xxs),
          EcLabelSmallText(
            'Mango',
            fontWeight: EcTypography.regular,
            color: colorScheme.surface,
          ),
          SizedBox(height: spacing.sm),
          EcRatingStarsView(rating: rating, totalReviews: totalReviews),
          SizedBox(height: spacing.sm),
          EcTitleMediumText('$price\$', height: EcTypography.normalHeight),
        ],
      ),
    );
  }
}
