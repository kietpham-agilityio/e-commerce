import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

/// {@template ec_product_card_in_bag}
/// A card widget for displaying a product in the shopping bag/cart.
///
/// This widget shows the product image, title, color, size, price, quantity,
/// and provides controls for incrementing/decrementing quantity and accessing
/// more options. It is intended for use in a shopping bag or cart list.
///
/// Example usage:
/// ```dart
/// EcProductCardInBag(
///   title: 'Pullover',
///   imageUrl: 'https://example.com/image.jpg',
///   isSoldOut: false,
///   color: 'Black',
///   size: 'L',
///   quantity: 1,
///   price: 51,
///   onMinor: () {},
///   onPlus: () {},
///   onMore: () {},
/// )
/// ```
///
/// - [title]: The product name.
/// - [isSoldOut]: Whether the product is sold out.
/// - [imageUrl]: The product image URL.
/// - [color]: The product color description.
/// - [size]: The product size description.
/// - [price]: The product price.
/// - [quantity]: The current quantity in the bag.
/// - [onMore]: Callback for the "more" button (optional).
/// - [onMinor]: Callback for the decrement button (optional).
/// - [onPlus]: Callback for the increment button (optional).
/// {@endtemplate}
class EcProductCardInBag extends StatelessWidget {
  /// {@macro ec_product_card_in_bag}
  const EcProductCardInBag({
    required this.title,
    this.isSoldOut = false,
    this.imageUrl = '',
    this.color,
    this.size,
    this.price,
    this.quantity,
    this.onMore,
    this.onMinor,
    this.onPlus,
    super.key,
  });

  /// The product name.
  final String title;

  /// Whether the product is sold out.
  final bool isSoldOut;

  /// The product image URL.
  final String imageUrl;

  /// The product color description.
  final String? color;

  /// The product size description.
  final String? size;

  /// The product price.
  final int? price;

  /// The current quantity in the bag.
  final int? quantity;

  /// Callback for the "more" button (optional).
  final VoidCallback? onMore;

  /// Callback for the decrement button (optional).
  final VoidCallback? onMinor;

  /// Callback for the increment button (optional).
  final VoidCallback? onPlus;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final colorScheme = ecTheme.colorScheme;
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = AppSpacing(themeExtension.themeType);

    return EcCardInList(
      url: imageUrl,
      isSoldOut: isSoldOut,
      content: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: spacing.md),
              EcTitleLargeText(title, fontWeight: FontWeight.bold),
              SizedBox(height: spacing.xxs),
              RichText(
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
              SizedBox(height: spacing.lg),
              Row(
                spacing: spacing.xl,
                children: [
                  EcIconButton(
                    showShadow: true,
                    icon: EcAssets.minor(),
                    onPressed: onMinor,
                    backgroundColor: colorScheme.onSurface,
                    iconColor: colorScheme.surface,
                  ),
                  EcBodyMediumText(
                    '$quantity',
                    height: EcTypography.normalHeight,
                  ),
                  EcIconButton(
                    showShadow: true,
                    icon: EcAssets.plus(),
                    onPressed: onPlus,
                    backgroundColor: colorScheme.onSurface,
                    iconColor: colorScheme.surface,
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
                icon: EcAssets.threeDots(),
                backgroundColor: Colors.transparent,
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
