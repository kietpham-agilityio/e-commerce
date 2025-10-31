import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

/// {@template ec_product_card_in_favorites}
/// A product card widget for displaying product information in the user's favorites list,
/// supporting both list and grid view layouts.
///
/// This widget adapts its layout based on the [isListView] flag:
/// - If [isListView] is true, it displays the product in a list-style card.
/// - If [isListView] is false, it displays the product in a grid-style card.
///
/// The card displays product image, title, brand, rating, price (with optional
/// discount), color, size, and an optional label (e.g., "New", "Sale").
/// It also supports showing a sold-out state, an add-to-cart button, and a close button.
///
/// Example usage:
/// ```dart
/// EcProductCardInFavorites(
///   title: 'Product Name',
///   brand: 'Brand',
///   imageUrl: 'https://example.com/image.png',
///   isSoldOut: false,
///   rating: 4.5,
///   totalReviews: 120,
///   originalPrice: 99.00.priceFormatter(),
///   discountedPrice: 79.99.priceFormatter(),
///   color: 'Red',
///   size: 'M',
///   isListView: true,
///   onAddToCard: () {},
///   onClose: () {},
///   labelText: 'New',
/// )
/// ```
/// {@endtemplate}
class EcProductCardInFavorites extends StatelessWidget {
  /// Creates a product card for use in a favorites view.
  ///
  /// [title] is required. Other fields are optional and provide additional
  /// product details and customization.
  const EcProductCardInFavorites({
    required this.title,
    this.brand = '',
    this.imageUrl = '',
    this.isSoldOut = false,
    this.rating = 0,
    this.totalReviews = 0,
    this.isListView = true,
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

  /// The main title of the product.
  final String title;

  /// The brand of the product.
  final String brand;

  /// Whether the product is sold out.
  final bool isSoldOut;

  /// The URL of the product image.
  final String imageUrl;

  /// The color of the product (optional).
  final String? color;

  /// The size of the product (optional).
  final String? size;

  /// The original price of the product (optional).
  final String? originalPrice;

  /// The discounted price of the product (optional).
  final String? discountedPrice;

  /// The quantity of the product (optional).
  final int? quantity;

  /// Callback when the add-to-cart button is pressed (optional).
  final VoidCallback? onAddToCard;

  /// The text of the label to display (optional).
  final String? labelText;

  /// The product's rating (0-5).
  final double rating;

  /// The total number of reviews for the product.
  final int totalReviews;

  /// Whether to display the card in list view (true) or grid view (false).
  final bool isListView;

  /// Callback when the close button is pressed (optional).
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final colorScheme = ecTheme.colorScheme;
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = themeExtension.spacing;

    return switch (isListView) {
      true => _ListView(
        imageUrl: imageUrl,
        isSoldOut: isSoldOut,
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

/// {@macro ec_product_card_in_favorites}
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
    this.labelText,
    this.onAddToCard,
    this.originalPrice,
    this.discountedPrice,
    this.color,
    this.size,
    this.onClose,
  });

  /// The URL of the product image.
  final String imageUrl;

  /// Whether the product is sold out.
  final bool isSoldOut;

  /// The text of the label to display (optional).
  final String? labelText;

  /// The spacing tokens for the current theme.
  final AppSpacing spacing;

  /// The color scheme for the current theme.
  final ColorScheme colorScheme;

  /// Callback when the add-to-cart button is pressed (optional).
  final VoidCallback? onAddToCard;

  /// The main title of the product.
  final String title;

  /// The brand of the product.
  final String brand;

  /// The product's rating (0-5).
  final double rating;

  /// The total number of reviews for the product.
  final int totalReviews;

  /// The original price of the product (optional).
  final String? originalPrice;

  /// The discounted price of the product (optional).
  final String? discountedPrice;

  /// The color of the product (optional).
  final String? color;

  /// The size of the product (optional).
  final String? size;

  /// Callback when the close button is pressed (optional).
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final l10n = AppLocale.of(context)!;

    return EcCardInGrid(
      url: imageUrl,
      isSoldOut: isSoldOut,
      onClose: onClose,
      actions: [
        if (labelText != null)
          Positioned(
            top: spacing.sm,
            left: spacing.sm,
            child: EcLabel(
              text: labelText ?? '',
              style: getLabelStyle(labelText!),
            ),
          ),
        Positioned(
          bottom: -16,
          right: 0,
          child: EcIconButton(
            size: 36,
            icon: EcAssets.shoppingBag(color: colorScheme.onPrimary),
            showShadow: true,
            onPressed: onAddToCard,
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EcRatingStarsView(rating: rating, totalReviews: totalReviews),
          SizedBox(height: spacing.xs),
          EcLabelSmallText(brand, color: colorScheme.outline),
          SizedBox(height: spacing.xxxs),
          EcTitleLargeText(title, fontWeight: EcTypography.bold),
          SizedBox(height: spacing.xxs),
          RichText(
            textScaler: MediaQuery.of(context).textScaler,
            text: TextSpan(
              style: ecTheme.textTheme.labelSmall?.copyWith(
                fontWeight: EcTypography.regular,
              ),
              children: [
                TextSpan(
                  text: '${l10n.generalColor}: ',
                  style: ecTheme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
                TextSpan(text: color),
                WidgetSpan(child: SizedBox(width: spacing.md)),
                TextSpan(
                  text: '${l10n.generalSize}: ',
                  style: ecTheme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
                TextSpan(text: size),
              ],
            ),
          ),
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
                      color: colorScheme.outline,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: colorScheme.outline,
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

/// {@macro ec_product_card_in_favorites}
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
    this.labelText,
    this.onAddToCard,
    this.originalPrice,
    this.discountedPrice,
    this.color,
    this.size,
    this.onClose,
  });

  /// The URL of the product image.
  final String imageUrl;

  /// Whether the product is sold out.
  final bool isSoldOut;

  /// The text of the label to display (optional).
  final String? labelText;

  /// The spacing tokens for the current theme.
  final AppSpacing spacing;

  /// The color scheme for the current theme.
  final ColorScheme colorScheme;

  /// Callback when the add-to-cart button is pressed (optional).
  final VoidCallback? onAddToCard;

  /// The main title of the product.
  final String title;

  /// The brand of the product.
  final String brand;

  /// The product's rating (0-5).
  final double rating;

  /// The total number of reviews for the product.
  final int totalReviews;

  /// The original price of the product (optional).
  final String? originalPrice;

  /// The discounted price of the product (optional).
  final String? discountedPrice;

  /// The color of the product (optional).
  final String? color;

  /// The size of the product (optional).
  final String? size;

  /// Callback when the close button is pressed (optional).
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final l10n = AppLocale.of(context)!;

    return EcCardInList(
      url: imageUrl,
      isSoldOut: isSoldOut,
      onClose: onClose,
      actions: [
        if (labelText != null)
          Positioned(
            top: spacing.sm,
            left: spacing.sm,
            child: EcLabel(
              text: labelText ?? '',
              style: getLabelStyle(labelText!),
            ),
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
          EcLabelSmallText(brand, color: colorScheme.outline),
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
                  text: '${l10n.generalColor}: ',
                  style: ecTheme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
                TextSpan(text: color),
                WidgetSpan(child: SizedBox(width: spacing.md)),
                TextSpan(
                  text: '${l10n.generalSize}: ',
                  style: ecTheme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.outline,
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
                          color: colorScheme.outline,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: colorScheme.outline,
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
