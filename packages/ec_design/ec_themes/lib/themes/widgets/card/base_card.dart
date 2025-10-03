import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

/// {@template ec_card_in_list}
/// A customizable card widget for displaying a product/item in a list view,
/// typically used in e-commerce applications.
///
/// Displays an image, content, and optional action buttons. Supports a "sold out"
/// overlay and an optional close button.
///
/// Example usage:
/// ```dart
/// EcCardInList(
///   url: 'https://example.com/image.png',
///   content: Text('Product details here'),
///   actions: [
///     Positioned(
///       right: 0,
///       bottom: -19,
///       child: EcIconButton(icon: Icon(Icons.favorite)),
///     ),
///   ],
///   isSoldOut: false,
///   onClose: () {},
/// )
/// ```
/// {@endtemplate}
class EcCardInList extends StatelessWidget {
  /// Creates an [EcCardInList].
  ///
  /// [url] is the image URL to display.
  /// [content] is the widget shown next to the image.
  /// [sizeImage] sets the image's width and height (default: 104).
  /// [isSoldOut] overlays a "sold out" indicator if true.
  /// [actions] is a list of widgets (usually [Positioned]) layered above the card.
  /// [onClose] shows a close button if provided.
  const EcCardInList({
    required this.url,
    required this.content,
    this.sizeImage = 104,
    this.isSoldOut = false,
    this.actions = const [],
    this.onClose,
    super.key,
  });

  /// The image URL to display.
  final String url;

  /// The main content widget displayed next to the image.
  final Widget content;

  /// The size (width and height) of the image.
  final double sizeImage;

  /// Whether to show the "sold out" overlay.
  final bool isSoldOut;

  /// List of widgets (typically [Positioned]) to overlay on the card.
  final List<Widget> actions;

  /// Callback for the close button. If null, no close button is shown.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      spacing: 7,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              color: colorScheme.primaryContainer,
              clipBehavior: Clip.antiAlias,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EcCachedNetworkImage(
                      width: sizeImage,
                      boxFit: BoxFit.cover,
                      url: url,
                    ),
                    SizedBox(width: 12),
                    Expanded(child: content),
                  ],
                ),
              ),
            ),
            if (actions.isNotEmpty && !isSoldOut) ...actions,
            if (isSoldOut)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colorScheme.surfaceDim.withValues(alpha: 0.7),
                  ),

                  alignment: Alignment.center,
                ),
              ),
            if (onClose != null)
              Positioned(
                top: 0,
                right: 0,
                child: EcIconButton(
                  icon: EcAssets.close(color: colorScheme.surface),
                  size: 40,
                  backgroundColor: Colors.transparent,
                  onPressed: onClose,
                ),
              ),
          ],
        ),
        if (isSoldOut)
          EcLabelSmallText(
            // FIXME: use l10n
            'Sorry, this item is currently sold out',
            letterSpacing: 0,
            fontWeight: FontWeight.w400,
            color: colorScheme.surface,
          )
        else
          SizedBox(height: 11),
      ],
    );
  }
}

/// {@template ec_card_in_grid}
/// A customizable card widget for displaying a product/item in a grid view,
/// typically used in e-commerce applications.
///
/// This widget displays a product image, main content, and optional action buttons.
/// It supports a "sold out" overlay and an optional close button.
///
/// Example usage:
/// ```dart
/// EcCardInGrid(
///   url: 'https://example.com/image.png',
///   content: Text('Product details here'),
///   actions: [
///     Positioned(
///       right: 0,
///       bottom: -19,
///       child: EcIconButton(icon: Icon(Icons.favorite)),
///     ),
///   ],
///   isSoldOut: false,
///   onClose: () {},
/// )
/// ```
///
/// - [url]: The image URL to display.
/// - [content]: The main content widget displayed below the image.
/// - [imageHeight]: The height of the product image (default: 184).
/// - [imageWidth]: The width of the product image (default: 162).
/// - [actions]: List of widgets (typically [Positioned]) to overlay on the image.
/// - [isSoldOut]: Whether to show the "sold out" overlay.
/// - [onClose]: Callback for the close button. If null, no close button is shown.
/// {@endtemplate}
class EcCardInGrid extends StatelessWidget {
  /// Creates an [EcCardInGrid].
  ///
  /// [url] is the image URL to display.
  /// [content] is the widget shown below the image.
  /// [imageHeight] sets the image's height (default: 184).
  /// [imageWidth] sets the image's width (default: 162).
  /// [actions] is a list of widgets (usually [Positioned]) layered above the image.
  /// [isSoldOut] overlays a "sold out" indicator if true.
  /// [onClose] shows a close button if provided.
  const EcCardInGrid({
    required this.url,
    required this.content,
    this.imageHeight = 184,
    this.imageWidth = 162,
    this.actions = const [],
    this.isSoldOut = false,
    this.onClose,
    super.key,
  });

  /// The image URL to display.
  final String url;

  /// The main content widget displayed below the image.
  final Widget content;

  /// The height of the product image.
  final double imageHeight;

  /// The width of the product image.
  final double imageWidth;

  /// List of widgets (typically [Positioned]) to overlay on the image.
  final List<Widget> actions;

  /// Whether to show the "sold out" overlay.
  final bool isSoldOut;

  /// Callback for the close button. If null, no close button is shown.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = AppSpacing(themeExtension.themeType);
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: imageWidth,
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            shadowColor: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: spacing.sm,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: EcCachedNetworkImage(
                        height: imageHeight,
                        width: imageWidth,
                        boxFit: BoxFit.cover,
                        url: url,
                      ),
                    ),
                    if (actions.isNotEmpty && !isSoldOut) ...actions,
                  ],
                ),
                content,
              ],
            ),
          ),
          if (isSoldOut)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: colorScheme.surfaceDim.withValues(alpha: 0.6),
                ),
                alignment: Alignment.center,
              ),
            ),
          if (isSoldOut)
            Positioned(
              top: imageHeight - 36,
              child: Container(
                width: imageWidth,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: colorScheme.onPrimary.withValues(alpha: 0.4),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: EcLabelSmallText(
                    // FIXME: use l10n
                    'Sorry, this item is currently sold out',
                    height: 1.2,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w400,
                    color: colorScheme.secondary,
                  ),
                ),
              ),
            ),
          if (onClose != null)
            Positioned(
              top: 0,
              right: 0,
              child: EcIconButton(
                icon: EcAssets.close(color: colorScheme.surface),
                size: 40,
                backgroundColor: Colors.transparent,
                onPressed: onClose,
              ),
            ),
        ],
      ),
    );
  }
}

EcLabelStyle getLabelStyle(String label) {
  return switch (label) {
    'NEW' => EcLabelStyle.secondary,
    _ => EcLabelStyle.primary,
  };
}
