import 'app_colors.dart';
import 'spacing/admin_spacing.dart';
import 'spacing/user_spacing.dart';

/// {@template app_spacing}
/// A theme-aware facade for spacing tokens used throughout the application.
///
/// Provides access to spacing values (in logical pixels) for both Admin and User themes,
/// abstracting away the underlying theme-specific definitions. Use this class to ensure
/// consistent spacing and to keep widgets theme-agnostic.
///
/// Spacing tokens follow a consistent scale:
/// - xxxs, xxs, xs, sm, md, lg, xl, xxl, xxxl, huge, massive, giant
///
/// See also:
/// - [AdminSpacing]
/// - [UserSpacing]
/// - [ECThemeType]
/// {@endtemplate}
class AppSpacing {
  /// Creates an [AppSpacing] facade for the given [ECThemeType].
  ///
  /// Use this to access theme-specific spacing tokens in a unified way.
  const AppSpacing(this.type);

  /// The current theme type (admin or user).
  final ECThemeType type;

  /// Extra extra extra small spacing.
  ///
  /// - Admin: [AdminSpacing.xxxs]
  /// - User: [UserSpacing.xxxs]
  double get xxxs => switch (type) {
        ECThemeType.admin => AdminSpacing.xxxs,
        ECThemeType.user => UserSpacing.xxxs,
      };

  /// Extra extra small spacing.
  ///
  /// - Admin: [AdminSpacing.xxs]
  /// - User: [UserSpacing.xxs]
  double get xxs => switch (type) {
        ECThemeType.admin => AdminSpacing.xxs,
        ECThemeType.user => UserSpacing.xxs,
      };

  /// Extra small spacing.
  ///
  /// - Admin: [AdminSpacing.xs]
  /// - User: [UserSpacing.xs]
  double get xs => switch (type) {
        ECThemeType.admin => AdminSpacing.xs,
        ECThemeType.user => UserSpacing.xs,
      };

  /// Small spacing.
  ///
  /// - Admin: [AdminSpacing.sm]
  /// - User: [UserSpacing.sm]
  double get sm => switch (type) {
        ECThemeType.admin => AdminSpacing.sm,
        ECThemeType.user => UserSpacing.sm,
      };

  /// Medium spacing.
  ///
  /// - Admin: [AdminSpacing.md]
  /// - User: [UserSpacing.md]
  double get md => switch (type) {
        ECThemeType.admin => AdminSpacing.md,
        ECThemeType.user => UserSpacing.md,
      };

  /// Large spacing.
  ///
  /// - Admin: [AdminSpacing.lg]
  /// - User: [UserSpacing.lg]
  double get lg => switch (type) {
        ECThemeType.admin => AdminSpacing.lg,
        ECThemeType.user => UserSpacing.lg,
      };

  /// Extra large spacing.
  ///
  /// - Admin: [AdminSpacing.xl]
  /// - User: [UserSpacing.xl]
  double get xl => switch (type) {
        ECThemeType.admin => AdminSpacing.xl,
        ECThemeType.user => UserSpacing.xl,
      };

  /// Extra extra large spacing.
  ///
  /// - Admin: [AdminSpacing.xxl]
  /// - User: [UserSpacing.xxl]
  double get xxl => switch (type) {
        ECThemeType.admin => AdminSpacing.xxl,
        ECThemeType.user => UserSpacing.xxl,
      };

  /// Extra extra extra large spacing.
  ///
  /// - Admin: [AdminSpacing.xxxl]
  /// - User: [UserSpacing.xxxl]
  double get xxxl => switch (type) {
        ECThemeType.admin => AdminSpacing.xxxl,
        ECThemeType.user => UserSpacing.xxxl,
      };

  /// Huge spacing.
  ///
  /// - Admin: [AdminSpacing.huge]
  /// - User: [UserSpacing.huge]
  double get huge => switch (type) {
        ECThemeType.admin => AdminSpacing.huge,
        ECThemeType.user => UserSpacing.huge,
      };

  /// Massive spacing.
  ///
  /// - Admin: [AdminSpacing.massive]
  /// - User: [UserSpacing.massive]
  double get massive => switch (type) {
        ECThemeType.admin => AdminSpacing.massive,
        ECThemeType.user => UserSpacing.massive,
      };

  /// Giant spacing.
  ///
  /// - Admin: [AdminSpacing.giant]
  /// - User: [UserSpacing.giant]
  double get giant => switch (type) {
        ECThemeType.admin => AdminSpacing.giant,
        ECThemeType.user => UserSpacing.giant,
      };
}
