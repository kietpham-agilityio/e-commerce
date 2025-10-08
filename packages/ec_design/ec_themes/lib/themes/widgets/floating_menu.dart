import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class EcFloatingMenu extends StatelessWidget {
  const EcFloatingMenu({super.key, this.onDelete, this.onAddToFavorites});

  final VoidCallback? onDelete;
  final VoidCallback? onAddToFavorites;

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = themeExt.spacing;
    final l10n = AppLocale.of(context)!;

    return MenuAnchor(
      alignmentOffset: const Offset(-160, -50),
      builder: (
        BuildContext context,
        MenuController controller,
        Widget? child,
      ) {
        return EcIconButton(
          icon: EcAssets.threeDots(),
          backgroundColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
      menuChildren: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.md),
          child: MenuItemButton(
            onPressed: onAddToFavorites,
            style: ButtonStyle(alignment: Alignment.center),
            child: EcLabelSmallText(
              l10n.generalAddToFavorites,
              textAlign: TextAlign.center,
              fontWeight: EcTypography.regular,
            ),
          ),
        ),
        Divider(thickness: 0, height: 0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.md),
          child: MenuItemButton(
            onPressed: onDelete,
            child: EcLabelSmallText(
              l10n.generalDeleteFromTheList,
              textAlign: TextAlign.center,
              fontWeight: EcTypography.regular,
            ),
          ),
        ),
      ],
    );
  }
}
