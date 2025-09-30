import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_sizing.dart';
import 'package:ec_themes/themes/app_spacing.dart';
import 'package:flutter/material.dart';

/// {@template rating_stars_view}
/// A widget that displays a row of star icons representing a rating,
/// along with the total number of reviews in parentheses.
///
/// The stars are filled, half-filled, or outlined based on the [rating] value.
/// For example, a rating of 3.5 will show 3 filled stars, 1 half-filled star,
/// and 1 outlined star. The number of reviews is displayed next to the stars.
///
/// Example usage:
/// ```dart
/// RatingStarsView(rating: 4.5, totalReviews: 120)
/// ```
///
/// - [rating]: The rating value (e.g., 4.5). Should be between 0 and 5.
/// - [totalReviews]: The total number of reviews to display.
/// {@endtemplate}
class RatingStarsView extends StatelessWidget {
  /// {@macro rating_stars_view}
  const RatingStarsView({
    required this.rating,
    required this.totalReviews,
    super.key,
  });

  /// The rating value to display (between 0 and 5).
  final double rating;

  /// The total number of reviews to display next to the stars.
  final int totalReviews;

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = AppSpacing(themeExtension.themeType);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(5, (index) {
            if (index < rating.floor()) {
              return EcAssets.starFilled();
            } else if (index < rating) {
              return EcAssets.starHalf();
            } else {
              return EcAssets.starOutlined();
            }
          }),
        ),
        SizedBox(width: spacing.xxxs),
        EcLabelSmallText(
          '($totalReviews)',
          fontWeight: EcTypography.regular,
          color: Theme.of(context).colorScheme.surface,
        ),
      ],
    );
  }
}

/// {@template rating_stars_action}
/// A widget that displays an interactive row of 5 rating stars, allowing the user to select a rating.
///
/// This widget is typically used for rating input, such as product or service reviews.
/// When a star is tapped, all stars up to that index are filled, and the [onChanged] callback is triggered
/// with the new rating value (from 1 to 5).
///
/// Example usage:
/// ```dart
/// RatingStarsAction(
///   onChanged: (rating) {
///     print('User selected rating: $rating');
///   },
/// )
/// ```
///
/// - [onChanged]: Callback that receives the new rating value when the user selects a star.
/// {@endtemplate}
class RatingStarsAction extends StatelessWidget {
  /// {@macro rating_stars_action}
  const RatingStarsAction({super.key, this.onChanged});

  /// Called when the user selects a new rating (1-5).
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    // Holds the current selected rating value.
    final ValueNotifier<int> rating = ValueNotifier(0);
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final sizing = AppSizing(themeExtension.themeType);

    return ValueListenableBuilder<int>(
      valueListenable: rating,
      builder: (context, value, _) {
        return Row(
          spacing: sizing.icon,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            return EcIconButton(
              highlightColor: Colors.transparent,
              onPressed: () {
                rating.value = index + 1;
                onChanged?.call(rating.value);
              },
              backgroundColor: Colors.transparent,
              icon:
                  index < value
                      ? EcAssets.starFilledBig(
                        width: sizing.iconButtonBig,
                        height: sizing.iconButtonBig,
                      )
                      : EcAssets.starOutlinedBig(
                        width: sizing.iconButtonBig,
                        height: sizing.iconButtonBig,
                      ),
            );
          }),
        );
      },
    );
  }
}
