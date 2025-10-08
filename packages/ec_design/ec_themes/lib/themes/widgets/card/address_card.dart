import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

/// {@template ec_address_card}
/// A card widget that displays a user's address information in a structured format.
///
/// The [EcAddressCard] shows the full name, street address, city, state, zipcode, and country.
/// It also displays a checkbox indicating if this is the shipping address, and an edit button
/// for modifying the address details.
///
/// This widget is styled according to the current theme and uses spacing and typography
/// from the [EcThemeExtension].
///
/// Example usage:
/// ```dart
/// EcAddressCard(
///   fullname: 'John Doe',
///   streetAddress: '123 Main St',
///   city: 'Springfield',
///   state: 'IL',
///   zipcode: '62704',
///   country: 'USA',
///   isShippingAddress: true,
///   onEdit: () { /* handle edit */ },
/// )
/// ```
///
/// All fields except [fullname] are optional.
/// {@endtemplate}
class EcAddressCard extends StatelessWidget {
  /// Creates an [EcAddressCard].
  ///
  /// [fullname] is required. All other fields are optional.
  const EcAddressCard({
    required this.fullname,
    this.isShippingAddress = false,
    this.streetAddress,
    this.county,
    this.city,
    this.zipcode,
    this.state,
    this.country,
    this.onEdit,
    super.key,
  });

  /// The full name of the address owner.
  final String fullname;

  /// Whether this address is the shipping address.
  final bool isShippingAddress;

  /// The street address (e.g., "123 Main St").
  final String? streetAddress;

  /// The county of the address (optional, may be unused).
  final String? county;

  /// The city of the address.
  final String? city;

  /// The zipcode or postal code.
  final String? zipcode;

  /// The state or province.
  final String? state;

  /// The country.
  final String? country;

  /// Callback when the edit button is pressed.
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
                streetAddress ?? '',
                height: EcTypography.normalHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: spacing.xs),
              child: EcBodyMediumText(
                l10n.generalFullAddress(
                  city ?? '',
                  state ?? '',
                  zipcode ?? '',
                  country ?? '',
                ),
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
