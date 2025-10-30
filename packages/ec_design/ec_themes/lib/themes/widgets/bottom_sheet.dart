import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class EcBottomSheet {
  static Future show(
    BuildContext context, {
    required Widget child,
    required String title,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
      ),
      builder: (context) {
        final ecTheme = Theme.of(context);
        final maxHeight = MediaQuery.of(context).size.height * 0.95;
        final themeExt = Theme.of(context).extension<EcThemeExtension>()!;
        final spacing = themeExt.spacing;

        return Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: ecTheme.colorScheme.onSurface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(34),
              topRight: Radius.circular(34),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: spacing.lg),
                child: Container(
                  height: 6,
                  width: 60,
                  decoration: BoxDecoration(
                    color: ecTheme.colorScheme.outline,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(height: spacing.xxxs),
              EcHeadlineSmallText(title, fontWeight: EcTypography.semiBold),
              SizedBox(height: spacing.md),
              Flexible(child: SingleChildScrollView(child: child)),
              SizedBox(height: spacing.massive),
            ],
          ),
        );
      },
    );
  }
}
