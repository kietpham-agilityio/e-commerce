import 'app_colors.dart';
import 'sizing/admin_sizing.dart';
import 'sizing/user_sizing.dart';

class AppSizing {
  const AppSizing(this.type);

  final ECThemeType type;

  double get smallIcon => switch (type) {
        ECThemeType.admin => AdminSizing.smallIcon,
        ECThemeType.user => UserSizing.smallIcon,
      };

  double get icon => switch (type) {
        ECThemeType.admin => AdminSizing.icon,
        ECThemeType.user => UserSizing.icon,
      };

  double get bigIcon => switch (type) {
        ECThemeType.admin => AdminSizing.bigIcon,
        ECThemeType.user => UserSizing.bigIcon,
      };

  double get switcher => switch (type) {
        ECThemeType.admin => AdminSizing.switcher,
        ECThemeType.user => UserSizing.switcher,
      };

  double get checkbox => switch (type) {
        ECThemeType.admin => AdminSizing.checkbox,
        ECThemeType.user => UserSizing.checkbox,
      };

  double get iconSlider => switch (type) {
        ECThemeType.admin => AdminSizing.iconSlider,
        ECThemeType.user => UserSizing.iconSlider,
      };

  double get appBarHeight => switch (type) {
        ECThemeType.admin => AdminSizing.appBar,
        ECThemeType.user => UserSizing.appBar,
      };

  double get tag => switch (type) {
        ECThemeType.admin => AdminSizing.tag,
        ECThemeType.user => UserSizing.tag,
      };

  double get dropdown => switch (type) {
        ECThemeType.admin => AdminSizing.dropdown,
        ECThemeType.user => UserSizing.dropdown,
      };

  double get iconButtonSmall => switch (type) {
        ECThemeType.admin => AdminSizing.iconButtonSmall,
        ECThemeType.user => UserSizing.iconButtonSmall,
      };

  double get iconButtonBig => switch (type) {
        ECThemeType.admin => AdminSizing.iconButtonBig,
        ECThemeType.user => UserSizing.iconButtonBig,
      };

  double get buttonSmall => switch (type) {
        ECThemeType.admin => AdminSizing.buttonSmall,
        ECThemeType.user => UserSizing.buttonSmall,
      };

  double get button => switch (type) {
        ECThemeType.admin => AdminSizing.button,
        ECThemeType.user => UserSizing.button,
      };

  double get searchBar => switch (type) {
        ECThemeType.admin => AdminSizing.searchBar,
        ECThemeType.user => UserSizing.searchBar,
      };

  double get textFieldSmall => switch (type) {
        ECThemeType.admin => AdminSizing.textFieldSmall,
        ECThemeType.user => UserSizing.textFieldSmall,
      };

  double get textFieldOrdinary => switch (type) {
        ECThemeType.admin => AdminSizing.textFieldOrdinary,
        ECThemeType.user => UserSizing.textFieldOrdinary,
      };
}
