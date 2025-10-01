import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

/// {@template ec_product_card_in_catalog}
/// A product card widget for displaying product information in a catalog,
/// supporting both list and grid view layouts.
///
/// This widget adapts its layout based on the [isListView] flag:
/// - If [isListView] is true, it displays the product in a list-style card.
/// - If [isListView] is false, it displays the product in a grid-style card.
///
/// The card displays product image, title, subtitle, rating, price (with optional
/// discount), and an optional favorite button. It also supports showing a label
/// (e.g., "New", "Sale") and a sold-out state.
///
/// Example usage:
/// ```dart
/// EcProductCardInCatalog(
///   title: 'Product Name',
///   subTitle: 'Category',
///   imageUrl: 'https://example.com/image.png',
///   isSoldOut: false,
///   rating: 4.5,
///   totalReviews: 120,
///   originalPrice: 99.99,
///   discountedPrice: 79.99,
///   isListView: true,
///   onFavorite: () {},
///   labelStyle: EcLabelStyle.primary,
///   labelText: 'New',
/// )
/// ```
/// {@endtemplate}
class EcProductCardInCatalog extends StatelessWidget {
  /// Creates a product card for use in a catalog view.
  ///
  /// [title] is required. Other fields are optional and provide additional
  /// product details and customization.
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

  /// The main title of the product.
  final String title;

  /// The subtitle or category of the product.
  final String subTitle;

  /// Whether the product is sold out.
  final bool isSoldOut;

  /// The URL of the product image.
  final String imageUrl;

  /// The color variant of the product (optional).
  final String? color;

  /// The size variant of the product (optional).
  final String? size;

  /// The original price of the product (optional).
  final String? originalPrice;

  /// The discounted price of the product (optional).
  final String? discountedPrice;

  /// The quantity of the product (optional).
  final int? quantity;

  /// Callback when the favorite button is pressed (optional).
  final VoidCallback? onFavorite;

  /// The style of the label to display (optional).
  final EcLabelStyle? labelStyle;

  /// The text of the label to display (optional).
  final String? labelText;

  /// The product's rating (0-5).
  final double rating;

  /// The total number of reviews for the product.
  final int totalReviews;

  /// Whether to display the card in list view (true) or grid view (false).
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

/// A private widget for displaying the product card in grid view layout.
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
  final String? originalPrice;
  final String? discountedPrice;

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

/// A private widget for displaying the product card in list view layout.
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
  final String? originalPrice;
  final String? discountedPrice;

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
