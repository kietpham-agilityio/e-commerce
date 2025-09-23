import 'app_colors.dart';
import 'sizing/admin_sizing.dart';
import 'sizing/user_sizing.dart';

/// AppSizing provides the standard heights for UI components in the app,
/// depending on the [ECThemeType] (admin or user).
///
/// **Note:** All values represent the *height* of the component.
/// This value is only correct for the *width* if the widget is square-shaped.
/// In other cases, the width will automatically scale according to the device's screen size and layout.
/// Use these values when you want to ensure consistent vertical sizing across
/// different themes.
///
/// Example usage:
/// ```dart
/// final adminSizing = AppSizing(ECThemeType.admin);
/// double buttonHeight = sizing.button; // height of button for admin theme
/// ```

class AppSizing {
  /// Creates an [AppSizing] instance for the given [type].
  const AppSizing(this.type);

  /// The current theme type (admin or user).
  final ECThemeType type;

  /// Height of a small icon.
  double get smallIcon => switch (type) {
    ECThemeType.admin => AdminSizing.smallIcon,
    ECThemeType.user => UserSizing.smallIcon,
  };

  /// Height of a standard icon.
  double get icon => switch (type) {
    ECThemeType.admin => AdminSizing.icon,
    ECThemeType.user => UserSizing.icon,
  };

  /// Height of a big icon.
  double get bigIcon => switch (type) {
    ECThemeType.admin => AdminSizing.bigIcon,
    ECThemeType.user => UserSizing.bigIcon,
  };

  /// Height of a switcher component.
  double get switcher => switch (type) {
    ECThemeType.admin => AdminSizing.switcher,
    ECThemeType.user => UserSizing.switcher,
  };

  /// Height of a checkbox.
  double get checkbox => switch (type) {
    ECThemeType.admin => AdminSizing.checkbox,
    ECThemeType.user => UserSizing.checkbox,
  };

  /// Height of an icon slider.
  double get iconSlider => switch (type) {
    ECThemeType.admin => AdminSizing.iconSlider,
    ECThemeType.user => UserSizing.iconSlider,
  };

  /// Height of the app bar.
  double get appBarHeight => switch (type) {
    ECThemeType.admin => AdminSizing.appBar,
    ECThemeType.user => UserSizing.appBar,
  };

  /// Height of a tag component.
  double get tag => switch (type) {
    ECThemeType.admin => AdminSizing.tag,
    ECThemeType.user => UserSizing.tag,
  };

  /// Height of a dropdown component.
  double get dropdown => switch (type) {
    ECThemeType.admin => AdminSizing.dropdown,
    ECThemeType.user => UserSizing.dropdown,
  };

  /// Height of a small icon button.
  double get iconButtonSmall => switch (type) {
    ECThemeType.admin => AdminSizing.iconButtonSmall,
    ECThemeType.user => UserSizing.iconButtonSmall,
  };

  /// Height of a big icon button.
  double get iconButtonBig => switch (type) {
    ECThemeType.admin => AdminSizing.iconButtonBig,
    ECThemeType.user => UserSizing.iconButtonBig,
  };

  /// Height of a small button.
  double get buttonSmall => switch (type) {
    ECThemeType.admin => AdminSizing.buttonSmall,
    ECThemeType.user => UserSizing.buttonSmall,
  };

  /// Height of a standard button.
  double get button => switch (type) {
    ECThemeType.admin => AdminSizing.button,
    ECThemeType.user => UserSizing.button,
  };

  /// Height of the search bar.
  double get searchBar => switch (type) {
    ECThemeType.admin => AdminSizing.searchBar,
    ECThemeType.user => UserSizing.searchBar,
  };

  /// Height of a small text field.
  double get textFieldSmall => switch (type) {
    ECThemeType.admin => AdminSizing.textFieldSmall,
    ECThemeType.user => UserSizing.textFieldSmall,
  };

  /// Height of a standard (ordinary) text field.
  double get textFieldOrdinary => switch (type) {
    ECThemeType.admin => AdminSizing.textFieldOrdinary,
    ECThemeType.user => UserSizing.textFieldOrdinary,
  };

  // Height of a expandedAppBar
  double get expandedAppBar => switch (type) {
    ECThemeType.admin => AdminSizing.expandedAppBar,
    ECThemeType.user => AdminSizing.expandedAppBar,
  };
}
