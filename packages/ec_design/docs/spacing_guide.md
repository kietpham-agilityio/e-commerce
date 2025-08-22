### App Spacing: Definition and Usage Guide

This guide explains how to define spacing tokens for Admin and User themes and how to consume them via the `AppSpacing` facade.

---

## Concepts

- **Spacing tokens**: constants representing spacing values in logical pixels (e.g., margins, padding, gaps between elements).
- Theme-specific definitions:
  - `packages/ec_design/lib/themes/spacing/admin_spacing.dart`
  - `packages/ec_design/lib/themes/spacing/user_spacing.dart`
- Theme-aware facade:
  - `packages/ec_design/lib/themes/app_spacing.dart`

Note: All values represent spacing in pixels for consistent layout and spacing across the application.

---

## Naming conventions for tokens

- Use clear, descriptive names reflecting spacing size: `xxxs`, `xxs`, `xs`, `sm`, `md`, `lg`, `xl`, `xxl`, `xxxl`, `huge`, `massive`, `giant`.
- Follow the established scale from smallest to largest for consistency.
- Keep names identical across Admin/User themes.

Examples:

- ✅ Good: `xxs`, `md`, `xl`, `huge`.
- ❌ Avoid: `spacing1`, `largeGap`.

---

## Spacing scale reference

| Token     | Value (px) |
|-----------|------------|
| `xxxs`    | 2          |
| `xxs`     | 4          |
| `xs`      | 6          |
| `sm`      | 8          |
| `md`      | 12         |
| `lg`      | 14         |
| `xl`      | 16         |
| `xxl`     | 18         |
| `xxxl`    | 20         |
| `huge`    | 22         |
| `massive` | 28         |
| `giant`   | 40         |

---

## Adding a new spacing token

1. Open both `AdminSpacing` and `UserSpacing` files.
2. Add a new constant with the same name in both classes (e.g., `enormous`).
3. Add a getter to `AppSpacing` that switches based on `ECThemeType`.

Example definitions:

```dart
// admin_spacing.dart
class AdminSpacing {
  static const double enormous = 60;
}

// user_spacing.dart
class UserSpacing {
  static const double enormous = 60;
}
```

Expose via `AppSpacing`:

```dart
class AppSpacing {
  const AppSpacing(this.type);
  final ECThemeType type;

  double get enormous => switch (type) {
        ECThemeType.admin => AdminSpacing.enormous,
        ECThemeType.user => UserSpacing.enormous,
      };
}
```

---

## Best practices

- Keep token names identical across `AdminSpacing` and `UserSpacing`.
- Prefer reading through `AppSpacing` rather than referencing theme classes directly.
- Use `const` for all token values for performance and clarity.
- Follow the 8-point grid system for consistent spacing relationships.
- When updating or adding tokens, update both theme classes and the facade.

---

## Quick references

- Admin tokens: `packages/ec_design/lib/themes/spacing/admin_spacing.dart`
- User tokens: `packages/ec_design/lib/themes/spacing/user_spacing.dart`
- Facade: `packages/ec_design/lib/themes/app_spacing.dart`

---

## Integrating with DI or theme

To avoid manual instantiation and keep widgets theme-agnostic:

1) Using simple dependency injection (GetIt example):

```dart
final getIt = GetIt.instance;

void configureSpacing(ECThemeType themeType) {
  getIt.registerSingleton<AppSpacing>(AppSpacing(themeType));
}

// Usage in widgets
final spacing = getIt<AppSpacing>();
Container(margin: EdgeInsets.all(spacing.md));
```

1) Providing via `InheritedWidget`/`Provider`:

```dart
class SpacingProvider extends InheritedWidget {
  const SpacingProvider({super.key, required this.spacing, required super.child});
  final AppSpacing spacing;

  static AppSpacing of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SpacingProvider>()!.spacing;

  @override
  bool updateShouldNotify(covariant SpacingProvider oldWidget) =>
      oldWidget.spacing.type != spacing.type;
}

// Usage
final spacing = SpacingProvider.of(context);
```

Ensure you update the provided `AppSpacing` when theme switches between Admin/User.

---

## More usage examples

Consistent padding and margins:

```dart
Container(
  margin: EdgeInsets.all(spacing.md),
  padding: EdgeInsets.symmetric(
    horizontal: spacing.lg,
    vertical: spacing.md,
  ),
  child: const Text('Content'),
);
```

List item spacing:

```dart
ListView.separated(
  itemCount: items.length,
  separatorBuilder: (context, index) => SizedBox(height: spacing.sm),
  itemBuilder: (context, index) => ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: spacing.md,
      vertical: spacing.sm,
    ),
    child: Text('Item $index'),
  ),
);
```

Form spacing:

```dart
Column(
  children: [
    TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(spacing.md),
      ),
    ),
    SizedBox(height: spacing.lg),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.xl,
          vertical: spacing.md,
        ),
      ),
      onPressed: () {},
      child: const Text('Submit'),
    ),
  ],
);
```

Grid spacing:

```dart
GridView.builder(
  padding: EdgeInsets.all(spacing.md),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: spacing.sm,
    mainAxisSpacing: spacing.md,
    childAspectRatio: 0.75,
  ),
  itemBuilder: (context, index) => ProductCard(),
);
```

---

## Testing spacing

Unit tests to ensure token parity and facade mapping:

```dart
void main() {
  test('AppSpacing maps md to AdminSpacing/UserSpacing correctly', () {
    expect(AppSpacing(ECThemeType.admin).md, AdminSpacing.md);
    expect(AppSpacing(ECThemeType.user).md, UserSpacing.md);
  });
}
```

Widget tests to assert layout spacing:

```dart
testWidgets('Container respects spacing margin', (tester) async {
  final spacing = AppSpacing(ECThemeType.user);
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(spacing.md),
          child: const Text('Content'),
        ),
      ),
    ),
  ));
  // Additional spacing assertions can be added using tester.getSize on the widget finder
});
```

---

## Migration tips

- When introducing new tokens, add to both Admin and User definitions first, then expose via `AppSpacing`.
- Replace hardcoded spacing values in widgets with `AppSpacing` getters.
- Roll out changes gradually: start with shared components (cards, buttons, text fields), then feature-specific widgets.

---

## Common pitfalls

- Defining a token in one theme but not the other → always mirror names and add corresponding getters.
- Using inconsistent spacing: remember to follow the 8-point grid system for visual harmony.
- Bypassing the facade: referencing `AdminSpacing`/`UserSpacing` directly makes code theme-coupled and harder to switch.
- Mixing spacing units: stick to the predefined tokens instead of mixing with hardcoded values.
