import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class EcOrderCard extends StatelessWidget {
  const EcOrderCard({
    required this.orderNumber,
    this.status = '',
    this.datetime = '',
    this.trackingNumber = '',
    this.amount = '',
    this.quantity = '',
    this.onDetails,
    super.key,
  });

  final String orderNumber;
  final String datetime;
  final String trackingNumber;
  final String amount;
  final String quantity;
  final String status;
  final VoidCallback? onDetails;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = themeExtension.spacing;
    final l10n = AppLocale.of(context)!;

    final statusColor = switch (OrderStatus.fromString(status)) {
      OrderStatus.delivered => ecTheme.colorScheme.tertiaryContainer,
      OrderStatus.processing => ecTheme.colorScheme.secondary,
      OrderStatus.cancelled => ecTheme.colorScheme.error,
    };

    return Card(
      color: ecTheme.colorScheme.onPrimary,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.xl,
          vertical: spacing.xxl,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  EcTitleLargeText(orderNumber),
                  EcTitleMediumText(
                    datetime,
                    color: ecTheme.colorScheme.outline,
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing.xl),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                children: [
                  EcTitleLargeText(
                    l10n.generalTrackingNumber,
                    fontWeight: EcTypography.regular,
                    color: ecTheme.colorScheme.outline,
                    height: EcTypography.tightHeight,
                  ),
                  SizedBox(width: spacing.sm),
                  EcTitleMediumText(
                    trackingNumber,
                    fontWeight: EcTypography.medium,
                    height: EcTypography.tightHeight,
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing.xxs),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      EcTitleLargeText(
                        '${l10n.generalQuantity}:',
                        fontWeight: EcTypography.regular,
                        color: ecTheme.colorScheme.outline,
                        height: EcTypography.tightHeight,
                      ),
                      SizedBox(width: spacing.md),
                      EcTitleLargeText(
                        quantity,
                        height: EcTypography.tightHeight,
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      EcTitleLargeText(
                        l10n.generalTotalAmount,
                        fontWeight: EcTypography.regular,
                        color: ecTheme.colorScheme.outline,
                        height: EcTypography.tightHeight,
                      ),
                      SizedBox(width: spacing.md),
                      EcTitleLargeText(
                        '$amount\$',
                        height: EcTypography.tightHeight,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing.lg),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 36,
                    child: EcOutlinedButton(
                      text: l10n.generalDetails,
                      onPressed: onDetails,
                    ),
                  ),
                  EcTitleLargeText(
                    status,
                    fontWeight: EcTypography.regular,
                    color: statusColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum OrderStatus {
  delivered,
  processing,
  cancelled;

  /// Enum -> String
  String get label {
    switch (this) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// String -> Enum
  static OrderStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'delivered':
        return OrderStatus.delivered;
      case 'processing':
        return OrderStatus.processing;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        throw ArgumentError('Invalid order status: $value');
    }
  }
}
