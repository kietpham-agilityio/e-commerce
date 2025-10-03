import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

/// {@template ec_product_card_in_main}
/// A product card widget for displaying product information in the main product grid,
/// typically used on the home or category pages.
///
/// This widget displays the product image, title, brand, rating, price (with optional
/// discount), and an optional label (e.g., "New", "Sale"). It also supports showing
/// a sold-out state and a favorite button.
///
/// Example usage:
/// ```dart
/// EcProductCardInMain(
///   title: 'Pullover',
///   brand: 'Mango',
///   imageUrl: 'https://example.com/image.png',
///   isSoldOut: false,
///   rating: 4.5,
///   totalReviews: 120,
///   originalPrice: 51.00.priceFormatter(),
///   discountedPrice: 20.55.priceFormatter(),
///   labelText: 'New',
///   onFavorite: () {},
/// )
/// ```
///
/// - [title] is required. Other fields are optional and provide additional
///   product details and customization.
/// {@endtemplate}
class EcProductCardInMain extends StatelessWidget {
  /// Creates a product card for use in the main product grid.
  ///
  /// [title] is required. Other fields are optional and provide additional
  /// product details and customization.
  const EcProductCardInMain({
    required this.title,
    this.brand = '',
    this.imageUrl = '',
    this.isSoldOut = false,
    this.rating = 0,
    this.totalReviews = 0,
    this.labelText,
    this.originalPrice,
    this.discountedPrice,
    this.quantity,
    this.onFavorite,
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

  /// The original price of the product (before discount), as a formatted string.
  final String? originalPrice;

  /// The discounted price of the product, as a formatted string.
  final String? discountedPrice;

  /// The available quantity of the product (optional).
  final int? quantity;

  /// Callback for the favorite button (optional).
  final VoidCallback? onFavorite;

  /// The text of the label to display (optional).
  final String? labelText;

  /// The product rating (0-5).
  final double rating;

  /// The total number of reviews for the product.
  final int totalReviews;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final colorScheme = ecTheme.colorScheme;
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = AppSpacing(themeExtension.themeType);

    return EcCardInGrid(
      imageWidth: 148,
      url: imageUrl,
      isSoldOut: isSoldOut,
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
            brand,
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
