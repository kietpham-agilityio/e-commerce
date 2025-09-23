import 'package:ec_themes/themes/app_sizing.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'ec_theme_extension.dart';
import 'typography.dart';

export 'app_shadows.dart';
export 'ec_theme_extension.dart';
export 'icons.dart';
export 'widgets/app_bar.dart';
export 'widgets/button.dart';
export 'widgets/checkbox.dart';
export 'widgets/example_pages/app_bar_example.dart';
export 'widgets/example_pages/checkbox_example.dart';
export 'widgets/example_pages/example_navigation.dart';
export 'widgets/example_pages/icon_button_example.dart';
export 'widgets/example_pages/tab_bar_example.dart';
export 'widgets/example_pages/tag_example.dart';
export 'widgets/icon_button.dart';
export 'widgets/tab_bar.dart';
export 'widgets/tag.dart';
export 'widgets/text.dart';
export 'widgets/textfield/big_input_text_field.dart';
export 'widgets/textfield/form_input.dart';
export 'widgets/textfield/ordinary_text_field.dart';
export 'widgets/textfield/search_text_field.dart';
export 'widgets/textfield/small_text_field.dart';

/// Design system themes for the e-commerce app
class EcDesignTheme {
  EcDesignTheme._();

  /// Light theme for the e-commerce app
  static ThemeData get lightTheme {
    return ThemeData(
      // Core theme properties
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: EcTypography.fontFamily,

      // Color scheme
      colorScheme: EcColors.light(ECThemeType.user),

      // Typography
      textTheme: _buildTextTheme(ECThemeType.user, false),

      // Input decoration theme
      inputDecorationTheme: _buildInputDecorationTheme(ECThemeType.user, false),

      // Button themes
      elevatedButtonTheme: _buildElevatedButtonTheme(ECThemeType.user, false),
      outlinedButtonTheme: _buildOutlinedButtonTheme(ECThemeType.user, false),
      textButtonTheme: _buildTextButtonTheme(ECThemeType.user, false),

      // Card theme
      cardTheme: _buildCardTheme(ECThemeType.user, false),

      // App bar theme
      appBarTheme: _buildAppBarTheme(ECThemeType.user, false),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(
        ECThemeType.user,
        false,
      ),

      // Floating action button theme
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(
        ECThemeType.user,
        false,
      ),

      // Dialog theme
      dialogTheme: _buildDialogTheme(ECThemeType.user, false),

      // Snackbar theme
      snackBarTheme: _buildSnackBarTheme(ECThemeType.user, false),

      // Chip theme
      chipTheme: _buildChipTheme(ECThemeType.user, false),

      // Divider theme
      dividerTheme: _buildDividerTheme(ECThemeType.user, false),

      // Icon theme
      iconTheme: _buildIconTheme(ECThemeType.user, false),

      // List tile theme
      listTileTheme: _buildListTileTheme(ECThemeType.user, false),

      // Switch theme
      switchTheme: _buildSwitchTheme(ECThemeType.user, false),

      // Checkbox theme
      checkboxTheme: _buildCheckboxTheme(ECThemeType.user, false),

      // Radio theme
      radioTheme: _buildRadioTheme(ECThemeType.user, false),

      // Slider theme
      sliderTheme: _buildSliderTheme(ECThemeType.user, false),

      // Tab bar theme
      tabBarTheme: _buildTabBarTheme(ECThemeType.user, false),

      // Progress indicator theme
      progressIndicatorTheme: _buildProgressIndicatorTheme(
        ECThemeType.user,
        false,
      ),

      // Popup menu theme
      popupMenuTheme: _buildPopupMenuTheme(ECThemeType.user, false),

      // Bottom sheet theme
      bottomSheetTheme: _buildBottomSheetTheme(ECThemeType.user, false),

      // Expansion tile theme
      expansionTileTheme: _buildExpansionTileTheme(ECThemeType.user, false),

      // EC Theme Extension
      extensions: const [
        EcThemeExtension(themeType: ECThemeType.user, isDark: false),
      ],
    );
  }

  /// Dark theme for the e-commerce app
  static ThemeData get darkTheme {
    return ThemeData(
      // Core theme properties
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: EcTypography.fontFamily,

      // Color scheme
      colorScheme: EcColors.dark(ECThemeType.user),

      // Typography
      textTheme: _buildTextTheme(ECThemeType.user, true),

      // Input decoration theme
      inputDecorationTheme: _buildInputDecorationTheme(ECThemeType.user, true),

      // Button themes
      elevatedButtonTheme: _buildElevatedButtonTheme(ECThemeType.user, true),
      outlinedButtonTheme: _buildOutlinedButtonTheme(ECThemeType.user, true),
      textButtonTheme: _buildTextButtonTheme(ECThemeType.user, true),

      // Card theme
      cardTheme: _buildCardTheme(ECThemeType.user, true),

      // App bar theme
      appBarTheme: _buildAppBarTheme(ECThemeType.user, true),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(
        ECThemeType.user,
        true,
      ),

      // Floating action button theme
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(
        ECThemeType.user,
        true,
      ),

      // Dialog theme
      dialogTheme: _buildDialogTheme(ECThemeType.user, true),

      // Snackbar theme
      snackBarTheme: _buildSnackBarTheme(ECThemeType.user, true),

      // Chip theme
      chipTheme: _buildChipTheme(ECThemeType.user, true),

      // Divider theme
      dividerTheme: _buildDividerTheme(ECThemeType.user, true),

      // Icon theme
      iconTheme: _buildIconTheme(ECThemeType.user, true),

      // List tile theme
      listTileTheme: _buildListTileTheme(ECThemeType.user, true),

      // Switch theme
      switchTheme: _buildSwitchTheme(ECThemeType.user, true),

      // Checkbox theme
      checkboxTheme: _buildCheckboxTheme(ECThemeType.user, true),

      // Radio theme
      radioTheme: _buildRadioTheme(ECThemeType.user, true),

      // Slider theme
      sliderTheme: _buildSliderTheme(ECThemeType.user, true),

      // Tab bar theme
      tabBarTheme: _buildTabBarTheme(ECThemeType.user, true),

      // Progress indicator theme
      progressIndicatorTheme: _buildProgressIndicatorTheme(
        ECThemeType.user,
        true,
      ),

      // Popup menu theme
      popupMenuTheme: _buildPopupMenuTheme(ECThemeType.user, true),

      // Bottom sheet theme
      bottomSheetTheme: _buildBottomSheetTheme(ECThemeType.user, true),

      // Expansion tile theme
      expansionTileTheme: _buildExpansionTileTheme(ECThemeType.user, true),

      // EC Theme Extension
      extensions: const [
        EcThemeExtension(themeType: ECThemeType.user, isDark: true),
      ],
    );
  }

  /// Admin light theme for the e-commerce app
  static ThemeData get adminLightTheme {
    return ThemeData(
      // Core theme properties
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: EcTypography.fontFamily,

      // Color scheme
      colorScheme: EcColors.light(ECThemeType.admin),

      // Typography
      textTheme: _buildTextTheme(ECThemeType.admin, false),

      // TBD: Implement admin-specific theme customizations
      inputDecorationTheme: _buildInputDecorationTheme(
        ECThemeType.admin,
        false,
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(ECThemeType.admin, false),
      outlinedButtonTheme: _buildOutlinedButtonTheme(ECThemeType.admin, false),
      textButtonTheme: _buildTextButtonTheme(ECThemeType.admin, false),
      cardTheme: _buildCardTheme(ECThemeType.admin, false),
      appBarTheme: _buildAppBarTheme(ECThemeType.admin, false),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(
        ECThemeType.admin,
        false,
      ),
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(
        ECThemeType.admin,
        false,
      ),
      dialogTheme: _buildDialogTheme(ECThemeType.admin, false),
      snackBarTheme: _buildSnackBarTheme(ECThemeType.admin, false),
      chipTheme: _buildChipTheme(ECThemeType.admin, false),
      dividerTheme: _buildDividerTheme(ECThemeType.admin, false),
      iconTheme: _buildIconTheme(ECThemeType.admin, false),
      listTileTheme: _buildListTileTheme(ECThemeType.admin, false),
      switchTheme: _buildSwitchTheme(ECThemeType.admin, false),
      checkboxTheme: _buildCheckboxTheme(ECThemeType.admin, false),
      radioTheme: _buildRadioTheme(ECThemeType.admin, false),
      sliderTheme: _buildSliderTheme(ECThemeType.admin, false),
      tabBarTheme: _buildTabBarTheme(ECThemeType.admin, false),
      progressIndicatorTheme: _buildProgressIndicatorTheme(
        ECThemeType.admin,
        false,
      ),
      popupMenuTheme: _buildPopupMenuTheme(ECThemeType.admin, false),
      bottomSheetTheme: _buildBottomSheetTheme(ECThemeType.admin, false),
      expansionTileTheme: _buildExpansionTileTheme(ECThemeType.admin, false),

      // EC Theme Extension
      extensions: const [
        EcThemeExtension(themeType: ECThemeType.admin, isDark: false),
      ],
    );
  }

  /// Admin dark theme for the e-commerce app
  static ThemeData get adminDarkTheme {
    return ThemeData(
      // Core theme properties
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: EcTypography.fontFamily,

      // Color scheme
      colorScheme: EcColors.dark(ECThemeType.admin),

      // Typography
      textTheme: _buildTextTheme(ECThemeType.admin, true),

      // TBD: Implement admin-specific theme customizations
      inputDecorationTheme: _buildInputDecorationTheme(ECThemeType.admin, true),
      elevatedButtonTheme: _buildElevatedButtonTheme(ECThemeType.admin, true),
      outlinedButtonTheme: _buildOutlinedButtonTheme(ECThemeType.admin, true),
      textButtonTheme: _buildTextButtonTheme(ECThemeType.admin, true),
      cardTheme: _buildCardTheme(ECThemeType.admin, true),
      appBarTheme: _buildAppBarTheme(ECThemeType.admin, true),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(
        ECThemeType.admin,
        true,
      ),
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(
        ECThemeType.admin,
        true,
      ),
      dialogTheme: _buildDialogTheme(ECThemeType.admin, true),
      snackBarTheme: _buildSnackBarTheme(ECThemeType.admin, true),
      chipTheme: _buildChipTheme(ECThemeType.admin, true),
      dividerTheme: _buildDividerTheme(ECThemeType.admin, true),
      iconTheme: _buildIconTheme(ECThemeType.admin, true),
      listTileTheme: _buildListTileTheme(ECThemeType.admin, true),
      switchTheme: _buildSwitchTheme(ECThemeType.admin, true),
      checkboxTheme: _buildCheckboxTheme(ECThemeType.admin, true),
      radioTheme: _buildRadioTheme(ECThemeType.admin, true),
      sliderTheme: _buildSliderTheme(ECThemeType.admin, true),
      tabBarTheme: _buildTabBarTheme(ECThemeType.admin, true),
      progressIndicatorTheme: _buildProgressIndicatorTheme(
        ECThemeType.admin,
        true,
      ),
      popupMenuTheme: _buildPopupMenuTheme(ECThemeType.admin, true),
      bottomSheetTheme: _buildBottomSheetTheme(ECThemeType.admin, true),
      expansionTileTheme: _buildExpansionTileTheme(ECThemeType.admin, true),

      // EC Theme Extension
      extensions: const [
        EcThemeExtension(themeType: ECThemeType.admin, isDark: true),
      ],
    );
  }

  // ===== THEME BUILDING FUNCTIONS =====

  /// Builds the text theme based on EcTypography system
  /// Provides different typography styles for each ECThemeType
  static TextTheme _buildTextTheme(ECThemeType themeType, bool isDark) {
    return TextTheme(
      // Display styles - different for user vs admin themes
      displayLarge: EcTypography.getDisplayLarge(themeType, isDark),
      displayMedium: EcTypography.getDisplayMedium(themeType, isDark),
      displaySmall: EcTypography.getDisplaySmall(themeType, isDark),

      // Headline styles - different for user vs admin themes
      headlineLarge: EcTypography.getHeadlineLarge(themeType, isDark),
      headlineMedium: EcTypography.getHeadlineMedium(themeType, isDark),
      headlineSmall: EcTypography.getHeadlineSmall(themeType, isDark),

      // Title styles - different for user vs admin themes
      titleLarge: EcTypography.getTitleLarge(themeType, isDark),
      titleMedium: EcTypography.getTitleMedium(themeType, isDark),
      titleSmall: EcTypography.getTitleSmall(themeType, isDark),

      // Body styles - different for user vs admin themes
      bodyLarge: EcTypography.getBodyLarge(themeType, isDark),
      bodyMedium: EcTypography.getBodyMedium(themeType, isDark),
      bodySmall: EcTypography.getBodySmall(themeType, isDark),

      // Label styles - different for user vs admin themes
      labelLarge: EcTypography.getLabelLarge(themeType, isDark),
      labelMedium: EcTypography.getLabelMedium(themeType, isDark),
      labelSmall: EcTypography.getLabelSmall(themeType, isDark),
    );
  }

  /// Build input decoration theme
  static InputDecorationTheme _buildInputDecorationTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);

    return InputDecorationTheme(
      // Default styling
      filled: true,
      fillColor: colors.primaryContainer,

      // Border styling
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.error),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.outline.withValues(alpha: 0.3)),
      ),

      // Content padding
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      // Text styles
      hintStyle: EcTypography.getLabelMedium(
        themeType,
        isDark,
      ).copyWith(color: colors.outline),
      helperStyle: EcTypography.getBodySmall(themeType, isDark),
      errorStyle: EcTypography.getBodySmall(
        themeType,
        isDark,
      ).copyWith(color: colors.error),
    );
  }

  /// Build elevated button theme
  static ElevatedButtonThemeData _buildElevatedButtonTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    final colorScheme =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    final sizing = AppSizing(themeType);

    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.7),
        disabledForegroundColor: colorScheme.onPrimary,
        minimumSize: Size.fromHeight(sizing.button),
        textStyle: EcTypography.getTitleMedium(themeType, isDark),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  /// Build outlined button theme
  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    final colorScheme =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);

    return OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.surface;
          }
          return colorScheme.secondary;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: colorScheme.surface);
          }
          return BorderSide(color: colorScheme.secondary);
        }),

        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
        textStyle: WidgetStatePropertyAll(
          EcTypography.getTitleMedium(themeType, isDark),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }

  /// TBD: Build text button theme
  static TextButtonThemeData _buildTextButtonTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const TextButtonThemeData();
  }

  /// TBD: Build card theme
  static CardThemeData _buildCardTheme(ECThemeType themeType, bool isDark) {
    return const CardThemeData();
  }

  /// TBD: Build app bar theme
  static AppBarTheme _buildAppBarTheme(ECThemeType themeType, bool isDark) {
    final colorScheme =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);

    return AppBarTheme(
      scrolledUnderElevation: 0,
      color: colorScheme.surfaceDim,
      foregroundColor: colorScheme.secondary,
    );
  }

  /// TBD: Build bottom navigation bar theme
  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const BottomNavigationBarThemeData();
  }

  /// TBD: Build floating action button theme
  static FloatingActionButtonThemeData _buildFloatingActionButtonTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const FloatingActionButtonThemeData();
  }

  /// TBD: Build dialog theme
  static DialogThemeData _buildDialogTheme(ECThemeType themeType, bool isDark) {
    return const DialogThemeData();
  }

  /// TBD: Build snackbar theme
  static SnackBarThemeData _buildSnackBarTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const SnackBarThemeData();
  }

  /// TBD: Build chip theme
  static ChipThemeData _buildChipTheme(ECThemeType themeType, bool isDark) {
    return const ChipThemeData();
  }

  /// TBD: Build divider theme
  static DividerThemeData _buildDividerTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const DividerThemeData();
  }

  /// TBD: Build icon theme
  static IconThemeData _buildIconTheme(ECThemeType themeType, bool isDark) {
    return const IconThemeData();
  }

  /// TBD: Build list tile theme
  static ListTileThemeData _buildListTileTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const ListTileThemeData();
  }

  /// TBD: Build switch theme
  static SwitchThemeData _buildSwitchTheme(ECThemeType themeType, bool isDark) {
    return const SwitchThemeData();
  }

  /// TBD: Build checkbox theme
  static CheckboxThemeData _buildCheckboxTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const CheckboxThemeData();
  }

  /// TBD: Build radio theme
  static RadioThemeData _buildRadioTheme(ECThemeType themeType, bool isDark) {
    return const RadioThemeData();
  }

  /// TBD: Build slider theme
  static SliderThemeData _buildSliderTheme(ECThemeType themeType, bool isDark) {
    return const SliderThemeData();
  }

  /// TBD: Build tab bar theme
  static TabBarThemeData _buildTabBarTheme(ECThemeType themeType, bool isDark) {
    return const TabBarThemeData();
  }

  /// TBD: Build progress indicator theme
  static ProgressIndicatorThemeData _buildProgressIndicatorTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const ProgressIndicatorThemeData();
  }

  /// TBD: Build popup menu theme
  static PopupMenuThemeData _buildPopupMenuTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const PopupMenuThemeData();
  }

  /// TBD: Build bottom sheet theme
  static BottomSheetThemeData _buildBottomSheetTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const BottomSheetThemeData();
  }

  /// TBD: Build expansion tile theme
  static ExpansionTileThemeData _buildExpansionTileTheme(
    ECThemeType themeType,
    bool isDark,
  ) {
    return const ExpansionTileThemeData();
  }
}
