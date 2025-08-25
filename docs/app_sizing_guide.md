### App Sizing: Definition and Usage Guide

This guide explains how to define sizing tokens for Admin and User themes and how to consume them via the `AppSizing` facade.

---

## Concepts

- **Sizing tokens**: constants representing component heights in logical pixels (e.g., buttons, icons, app bar, text fields).
- Theme-specific definitions:
  - `packages/ec_design/lib/themes/sizing/admin_sizing.dart`
  - `packages/ec_design/lib/themes/sizing/user_sizing.dart`
- Theme-aware facade:
  - `packages/ec_design/lib/themes/app_sizing.dart`

Note: All values represent heights. Widths depend on layout unless the widget is square.

---

## Naming conventions for tokens

- Use clear, descriptive names reflecting component and size: `button`, `buttonSmall`, `icon`, `bigIcon`, `textFieldOrdinary`.
- Prefer suffixes like `Small`, `Big`, `Ordinary` when meaningful. Keep names consistent across Admin/User.
- Avoid ambiguous names (e.g., `large` without context). If it’s a height for a specific widget, include the widget name.

Examples:

- ✅ Good: `iconButtonSmall`, `textFieldSmall`, `appBar`, `searchBar`.
- ❌ Avoid: `size1`, `largeHeight`.

---

## Adding a new sizing token

1. Open both `AdminSizing` and `UserSizing` files.
2. Add a new constant with the same name in both classes (e.g., `chipSmall`).
3. Add a getter to `AppSizing` that switches based on `ECThemeType`.

Example definitions:

```dart
// admin_sizing.dart
class AdminSizing {
  static const double chipSmall = 28;
}

// user_sizing.dart
class UserSizing {
  static const double chipSmall = 28;
}
```

Expose via `AppSizing`:

```dart
class AppSizing {
  const AppSizing(this.type);
  final ECThemeType type;

  double get chipSmall => switch (type) {
        ECThemeType.admin => AdminSizing.chipSmall,
        ECThemeType.user => UserSizing.chipSmall,
      };
}
```

---

## Best practices

- Keep token names identical across `AdminSizing` and `UserSizing`.
- Prefer reading through `AppSizing` rather than referencing theme classes directly.
- Use `const` for all token values for performance and clarity.
- Document each token briefly to clarify its purpose.
- When updating or adding tokens, update both theme classes and the facade.

---

## Quick references

- Admin tokens: `packages/ec_design/lib/themes/sizing/admin_sizing.dart`
- User tokens: `packages/ec_design/lib/themes/sizing/user_sizing.dart`
- Facade: `packages/ec_design/lib/themes/app_sizing.dart`

---

## Integrating with DI or theme

To avoid manual instantiation and keep widgets theme-agnostic:

1) Using simple dependency injection (GetIt example):

```dart
final getIt = GetIt.instance;

void configureSizing(ECThemeType themeType) {
  getIt.registerSingleton<AppSizing>(AppSizing(themeType));
}

// Usage in widgets
final sizing = getIt<AppSizing>();
SizedBox(height: sizing.dropdown);
```

2) Providing via `InheritedWidget`/`Provider`:

```dart
class SizingProvider extends InheritedWidget {
  const SizingProvider({super.key, required this.sizing, required super.child});
  final AppSizing sizing;

  static AppSizing of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SizingProvider>()!.sizing;

  @override
  bool updateShouldNotify(covariant SizingProvider oldWidget) =>
      oldWidget.sizing.type != sizing.type;
}

// Usage
final sizing = SizingProvider.of(context);
```

Ensure you update the provided `AppSizing` when theme switches between Admin/User.

---

## More usage examples

Buttons with consistent heights:

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(sizing.button)),
  onPressed: () {},
  child: const Text('Continue'),
);
```

Chips/Tags:

```dart
Container(
  height: sizing.tag,
  padding: const EdgeInsets.symmetric(horizontal: 12),
  alignment: Alignment.center,
  child: const Text('New'),
);
```

Search bar:

```dart
SizedBox(
  height: sizing.searchBar,
  child: TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search))),
);
```

AppBar height (custom widgets):

```dart
PreferredSize(
  preferredSize: Size.fromHeight(sizing.appBarHeight),
  child: const MyAppBar(),
);
```

---

## Testing sizing

Unit tests to ensure token parity and facade mapping:

```dart
void main() {
  test('AppSizing maps button to AdminSizing/UserSizing correctly', () {
    expect(AppSizing(ECThemeType.admin).button, AdminSizing.button);
    expect(AppSizing(ECThemeType.user).button, UserSizing.button);
  });
}
```

Widget tests to assert layout heights:

```dart
testWidgets('Button respects sizing height', (tester) async {
  final sizing = AppSizing(ECThemeType.user);
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(sizing.button)),
          onPressed: () {},
          child: const Text('Submit'),
        ),
      ),
    ),
  ));
  // Additional size assertions can be added using tester.getSize on the widget finder
});
```

---

## Migration tips

- When introducing new tokens, add to both Admin and User definitions first, then expose via `AppSizing`.
- Replace hardcoded heights in widgets with `AppSizing` getters.
- Roll out changes gradually: start with shared components (buttons, text fields, app bars), then feature-specific widgets.

---

## Common pitfalls

- Defining a token in one theme but not the other → always mirror names and add corresponding getters.
- Using width assumptions: remember tokens are heights; width should be handled by layout.
- Bypassing the facade: referencing `AdminSizing`/`UserSizing` directly makes code theme-coupled and harder to switch.
