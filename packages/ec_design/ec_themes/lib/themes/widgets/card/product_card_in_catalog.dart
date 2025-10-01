import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class EcProductCardInCatalog extends StatelessWidget {
  const EcProductCardInCatalog({
    required this.title,
    this.subTitle = '',
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
    this.onFavorite,
    super.key,
  });

  final String title;

  final String subTitle;

  final bool isSoldOut;

  final String imageUrl;

  final String? color;

  final String? size;

  final double? originalPrice;

  final double? discountedPrice;

  final int? quantity;

  final VoidCallback? onFavorite;

  final EcLabelStyle? labelStyle;

  final String? labelText;

  final double rating;

  final int totalReviews;

  final bool isListView;

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
        onFavorite: onFavorite,
        title: title,
        subTitle: subTitle,
        rating: rating,
        totalReviews: totalReviews,
        originalPrice: originalPrice,
        discountedPrice: discountedPrice,
      ),

      false => _GridView(
        imageUrl: imageUrl,
        isSoldOut: isSoldOut,
        labelStyle: labelStyle,
        labelText: labelText,
        spacing: spacing,
        colorScheme: colorScheme,
        onFavorite: onFavorite,
        title: title,
        subTitle: subTitle,
        rating: rating,
        totalReviews: totalReviews,
        originalPrice: originalPrice,
        discountedPrice: discountedPrice,
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
    required this.subTitle,
    required this.rating,
    required this.totalReviews,
    this.labelStyle,
    this.labelText,
    this.onFavorite,
    this.originalPrice,
    this.discountedPrice,
  });

  final String imageUrl;
  final bool isSoldOut;
  final EcLabelStyle? labelStyle;
  final String? labelText;
  final AppSpacing spacing;
  final ColorScheme colorScheme;
  final VoidCallback? onFavorite;
  final String title;
  final String subTitle;
  final double rating;
  final int totalReviews;
  final double? originalPrice;
  final double? discountedPrice;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);

    return EcCardInGrid(
      url: imageUrl,
      isSoldOut: isSoldOut,
      actions: [
        if (labelStyle != null && labelText != null)
          Positioned(
            top: spacing.sm,
            left: spacing.sm,
            child: EcLabel(text: labelText ?? '', style: labelStyle!),
          ),
        Positioned(
          bottom: -16,
          right: 0,
          child: EcIconButton(
            size: 36,
            icon: EcAssets.heart(color: colorScheme.surface),
            backgroundColor: colorScheme.primaryContainer,
            showShadow: true,
            onPressed: onFavorite,
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EcRatingStarsView(rating: rating, totalReviews: totalReviews),
          SizedBox(height: spacing.xs),
          EcLabelSmallText(
            subTitle,
            fontWeight: EcTypography.regular,
            color: colorScheme.surface,
          ),
          SizedBox(height: spacing.xs),
          EcTitleLargeText(title, fontWeight: EcTypography.bold),
          SizedBox(height: spacing.xxs),
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
        ],
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({
    required this.imageUrl,
    required this.isSoldOut,
    required this.spacing,
    required this.colorScheme,
    required this.title,
    required this.subTitle,
    required this.rating,
    required this.totalReviews,
    this.labelStyle,
    this.labelText,
    this.onFavorite,
    this.originalPrice,
    this.discountedPrice,
  });

  final String imageUrl;
  final bool isSoldOut;
  final EcLabelStyle? labelStyle;
  final String? labelText;
  final AppSpacing spacing;
  final ColorScheme colorScheme;
  final VoidCallback? onFavorite;
  final String title;
  final String subTitle;
  final double rating;
  final int totalReviews;
  final double? originalPrice;
  final double? discountedPrice;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);

    return EcCardInList(
      url: imageUrl,
      isSoldOut: isSoldOut,
      actions: [
        if (labelStyle != null && labelText != null)
          Positioned(
            top: spacing.sm,
            left: spacing.sm,
            child: EcLabel(text: labelText ?? '', style: labelStyle!),
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
            subTitle,
            fontWeight: EcTypography.regular,
            color: colorScheme.surface,
          ),
          SizedBox(height: spacing.sm),
          EcRatingStarsView(rating: rating, totalReviews: totalReviews),
          SizedBox(height: spacing.sm),
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
          SizedBox(height: spacing.sm),
        ],
      ),
    );
  }
}
