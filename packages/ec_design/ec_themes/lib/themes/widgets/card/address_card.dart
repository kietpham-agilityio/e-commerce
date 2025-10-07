import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class EcAddressCard extends StatelessWidget {
  const EcAddressCard({
    required this.fullname,
    this.isShippingAddress = false,
    this.streetAddress = '',
    this.county = '',
    this.city = '',
    this.zipcode = '',
    this.state = '',
    this.country = '',
    this.onEdit,
    super.key,
  });

  final String fullname;
  final bool isShippingAddress;
  final String streetAddress;
  final String county;
  final String city;
  final String zipcode;
  final String state;
  final String country;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context);
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = themeExtension.spacing;
    final l10n = AppLocale.of(context)!;

    return Card(
      color: ecTheme.colorScheme.onPrimary,
      child: Padding(
        padding: EdgeInsets.only(
          top: spacing.xs,
          left: spacing.huge,
          bottom: spacing.md,
          right: spacing.xs,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: spacing.xs),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    EcTitleLargeText(fullname),
                    EcTextButton(text: l10n.generalEditBtn, onPressed: onEdit),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: spacing.xs),
              child: EcBodyMediumText(
                streetAddress,
                height: EcTypography.normalHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: spacing.xs),
              child: EcBodyMediumText(
                l10n.generalFullAddress(city, state, zipcode, country),
                height: EcTypography.normalHeight,
              ),
            ),
            SizedBox(height: spacing.xs),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  EcCheckbox(
                    value: isShippingAddress,
                    fillColor: ecTheme.colorScheme.secondary,
                  ),
                  SizedBox(width: spacing.sm),
                  EcBodyMediumText(
                    l10n.generalTitleOfCheckboxShipping,
                    height: EcTypography.normalHeight,
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
