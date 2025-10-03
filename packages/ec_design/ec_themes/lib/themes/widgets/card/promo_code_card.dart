import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_sizing.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

/// {@template ec_promo_code_card}
/// A card widget that displays a promotional code with discount information,
/// remaining days, and an apply button.
///
/// The card features:
/// - An image background (from [imageUrl])
/// - The promo code name ([nameCode]) and code ([discountCode])
/// - The number of days remaining ([remainingDays])
/// - The discount percent ([discountPercent]) displayed with contrast-aware text
/// - An "Apply" button that triggers [onApply] when pressed
///
/// This widget is theme-aware and adapts its layout and colors to the current theme.
/// {@endtemplate}
class EcPromoCodeCard extends StatelessWidget {
  /// Creates an [EcPromoCodeCard].
  ///
  /// [imageUrl] is required and provides the background image for the card.
  /// [nameCode] is the name/title of the promo code.
  /// [discountCode] is the actual code string.
  /// [remainingDays] is the number of days left for the promo.
  /// [discountPercent] is the discount percentage to display.
  /// [onApply] is the callback when the apply button is pressed.
  const EcPromoCodeCard({
    super.key,
    required this.imageUrl,
    this.nameCode = '',
    this.discountCode = '',
    this.remainingDays = 0,
    this.discountPercent = 0,
    this.onApply,
  });

  /// The URL of the image to display as the card's background.
  final String imageUrl;

  /// The name/title of the promo code.
  final String nameCode;

  /// The actual promo code string.
  final String discountCode;

  /// The number of days remaining for the promo.
  final int remainingDays;

  /// The discount percentage to display.
  final int discountPercent;

  /// Callback when the "Apply" button is pressed.
  final VoidCallback? onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = AppSpacing(themeExtension.themeType);
    final colorScheme = Theme.of(context).colorScheme;
    final sizing = AppSizing(themeExtension.themeType);

    return Stack(
      children: [
        EcCardInList(
          url: imageUrl,
          content: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EcTitleLargeText(nameCode),
                    SizedBox(height: spacing.xxs),
                    EcLabelSmallText(
                      discountCode,
                      fontWeight: EcTypography.regular,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      EcLabelSmallText(
                        l10n.generalDaysRemaining(remainingDays),
                        color: colorScheme.surface,
                      ),
                      SizedBox(height: spacing.md),
                      SizedBox(
                        height: sizing.buttonSmall,
                        child: EcElevatedButton(
                          text: l10n.generalApply,
                          onPressed: onApply ?? () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          sizeImage: 80,
        ),
        Positioned.fill(
          left: 10,
          bottom: 11,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ContrastTextOnImage(
              text: discountPercent.toString(),
              imageUrl: imageUrl,
            ),
          ),
        ),
      ],
    );
  }
}

/// {@template contrast_text_on_image}
/// A widget that displays a discount percentage (and optional text) on top of an image,
/// automatically determining a contrasting text color based on the image's dominant color.
///
/// Used to ensure text is readable regardless of the image background.
/// {@endtemplate}
class ContrastTextOnImage extends StatelessWidget {
  /// Creates a [ContrastTextOnImage].
  ///
  /// [imageUrl] is required and is used to extract the dominant color for contrast calculation.
  /// [text] is the main text to display (typically the discount percent).
  const ContrastTextOnImage({required this.imageUrl, this.text, super.key});

  /// The URL of the image to analyze for dominant color.
  final String imageUrl;

  /// The main text to display (e.g., discount percent).
  final String? text;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);

    /// Asynchronously gets the dominant color from the image at [imageUrl].
    Future<Color> getDominantColor() async {
      final palette = await PaletteGenerator.fromImageProvider(
        NetworkImage(imageUrl),
      );
      return palette.dominantColor?.color ?? ecTheme.colorScheme.onPrimary;
    }

    return FutureBuilder<Color>(
      future: getDominantColor(),
      builder: (context, snapshot) {
        final dominantColor = snapshot.data ?? ecTheme.colorScheme.onPrimary;
        final brightness = ThemeData.estimateBrightnessForColor(dominantColor);
        final textColor =
            brightness == Brightness.dark
                ? ecTheme.colorScheme.onPrimary
                : ecTheme.colorScheme.secondary;

        return Row(
          children: [
            EcDisplayMediumText(text ?? '', color: textColor),
            SizedBox(width: 2),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EcTitleMediumText(
                  '%',
                  color: textColor,
                  fontWeight: EcTypography.bold,
                ),
                EcTitleMediumText(
                  'off',
                  color: textColor,
                  fontWeight: EcTypography.bold,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
