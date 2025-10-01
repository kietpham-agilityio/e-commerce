import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class EcProductCardInFavorites extends StatelessWidget {
  const EcProductCardInFavorites({
    required this.title,
    this.brand = '',
    this.imageUrl = '',
    this.isSoldOut = false,
    this.rating = 0,
    this.totalReviews = 0,
    this.isListView = true,
    this.labelStyle,
    this.labelText,
    this.color,
    this.size,
    this.originalPrice,
    this.discountedPrice,
    this.quantity,
    this.onAddToCard,
    this.onClose,
    super.key,
  });

  final String title;

  final String brand;

  final bool isSoldOut;

  final String imageUrl;

  final String? color;

  final String? size;

  final String? originalPrice;

  final String? discountedPrice;

  final int? quantity;

  final VoidCallback? onAddToCard;

  final EcLabelStyle? labelStyle;

  final String? labelText;

  final double rating;

  final int totalReviews;

  final bool isListView;

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final colorScheme = ecTheme.colorScheme;
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = AppSpacing(themeExtension.themeType);

    return switch (isListView) {
      true => _ListView(
        imageUrl: imageUrl,
        isSoldOut: isSoldOut,
        labelStyle: labelStyle,
        labelText: labelText,
        spacing: spacing,
        colorScheme: colorScheme,
        onAddToCard: onAddToCard,
        title: title,
        brand: brand,
        rating: rating,
        totalReviews: totalReviews,
        originalPrice: originalPrice,
        discountedPrice: discountedPrice,
        color: color,
        size: size,
        onClose: onClose,
      ),

      false => _GridView(
        imageUrl: imageUrl,
        isSoldOut: isSoldOut,
        labelStyle: labelStyle,
        labelText: labelText,
        spacing: spacing,
        colorScheme: colorScheme,
        onAddToCard: onAddToCard,
        title: title,
        brand: brand,
        rating: rating,
        totalReviews: totalReviews,
        originalPrice: originalPrice,
        discountedPrice: discountedPrice,
        color: color,
        size: size,
        onClose: onClose,
      ),
    };
  }
}

class _GridView extends StatelessWidget {
  const _GridView({
    required this.imageUrl,
    required this.isSoldOut,
    required this.spacing,
    required this.colorScheme,
    required this.title,
    required this.brand,
    required this.rating,
    required this.totalReviews,
    this.labelStyle,
    this.labelText,
    this.onAddToCard,
    this.originalPrice,
    this.discountedPrice,
    this.color,
    this.size,
    this.onClose,
  });

  final String imageUrl;
  final bool isSoldOut;
  final EcLabelStyle? labelStyle;
  final String? labelText;
  final AppSpacing spacing;
  final ColorScheme colorScheme;
  final VoidCallback? onAddToCard;
  final String title;
  final String brand;
  final double rating;
  final int totalReviews;
  final String? originalPrice;
  final String? discountedPrice;
  final String? color;
  final String? size;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);

    return Container();
  }
}

class _ListView extends StatelessWidget {
  const _ListView({
    required this.imageUrl,
    required this.isSoldOut,
    required this.spacing,
    required this.colorScheme,
    required this.title,
    required this.brand,
    required this.rating,
    required this.totalReviews,
    this.labelStyle,
    this.labelText,
    this.onAddToCard,
    this.originalPrice,
    this.discountedPrice,
    this.color,
    this.size,
    this.onClose,
  });

  final String imageUrl;
  final bool isSoldOut;
  final EcLabelStyle? labelStyle;
  final String? labelText;
  final AppSpacing spacing;
  final ColorScheme colorScheme;
  final VoidCallback? onAddToCard;
  final String title;
  final String brand;
  final double rating;
  final int totalReviews;
  final String? originalPrice;
  final String? discountedPrice;
  final String? color;
  final String? size;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);

    return EcCardInList(
      url: imageUrl,
      isSoldOut: isSoldOut,
      onClose: onClose,
      actions: [
        if (labelStyle != null && labelText != null)
          Positioned(
            top: spacing.sm,
            left: spacing.sm,
            child: EcLabel(text: labelText ?? '', style: labelStyle!),
          ),
        Positioned(
          bottom: -12,
          right: 0,
          child: EcIconButton(
            icon: EcAssets.shoppingBag(color: colorScheme.onPrimary),
            showShadow: true,
            onPressed: onAddToCard,
          ),
        ),
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: spacing.lg),
          EcLabelSmallText(
            brand,
            fontWeight: EcTypography.regular,
            color: colorScheme.surface,
          ),
          SizedBox(height: spacing.xxxs),
          EcTitleLargeText(title, fontWeight: EcTypography.bold),
          SizedBox(height: spacing.xs),
          RichText(
            textScaler: MediaQuery.of(context).textScaler,
            text: TextSpan(
              style: ecTheme.textTheme.labelSmall?.copyWith(
                fontWeight: EcTypography.regular,
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
          SizedBox(height: spacing.sm),
          Wrap(
            children: [
              if (discountedPrice == null)
                EcTitleMediumText(
                  '$originalPrice\$',
                  height: EcTypography.normalHeight,
                )
              else
                RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    style: ecTheme.textTheme.titleMedium?.copyWith(
                      height: EcTypography.normalHeight,
                    ),
                    children: [
                      TextSpan(
                        text: '$originalPrice\$',
                        style: ecTheme.textTheme.titleMedium?.copyWith(
                          height: EcTypography.normalHeight,
                          color: colorScheme.surface,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: colorScheme.surface,
                        ),
                      ),
                      WidgetSpan(child: SizedBox(width: spacing.xxs)),
                      TextSpan(
                        text: '$discountedPrice\$',
                        style: ecTheme.textTheme.titleMedium?.copyWith(
                          height: EcTypography.normalHeight,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(width: 52),
              EcRatingStarsView(rating: rating, totalReviews: totalReviews),
            ],
          ),

          SizedBox(height: spacing.sm),
        ],
      ),
    );
  }
}
