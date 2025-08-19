# Color Scheme Usage Guide (Flutter)

This guide explains **what each color in `EcColors` is for** and **how to use them correctly** in your widgets. It's based on Flutter's `ColorScheme` and your palette `EcPalette` from `app_palette.dart`.

> TL;DR: **Never hardcode colors** in widgets (e.g., `Colors.red`). Always read from `Theme.of(context).colorScheme` to keep light/dark mode and branding consistent.

---

## EcTheme

- **Palettes**: Colors are defined in `packages/ec_design/lib/themes/light_palette.dart` and `packages/ec_design/lib/themes/dark_palette.dart`. The app-level schemes that pick the right palette per theme type live in `packages/ec_design/lib/themes/app_colors.dart`.
- **Ten shades per colour**: Each colour provides ten shades (50 → 900). The shade marked at index 500 is the **primary** for that colour.
- **Usage**: Do not reference palette colours directly in widgets. Use `EcColors` via `Theme.of(context).colorScheme` which automatically resolves the correct colour for the current `ECThemeType` (e.g., user/admin) and device mode (light/dark).
- **Source of truth**: Define both light and dark themes based on the Design System tokens. See the Design System on Figma: [E‑commerce Application](https://www.figma.com/design/xbkKEr5wsis24LAc02n8mt/E-commerce-Application?node-id=23097-326&t=dZssbUD68nV0oyxm-4).


## 1. Do & Don't

**Do**
- ✅ Reference `Theme.of(context).colorScheme` everywhere.
- ✅ Pair `on*` with its corresponding background (`primary` ⇄ `onPrimary`, etc.).
- ✅ Keep contrast high for readability.

**Don't**
- ❌ Hardcode `Colors.white` or `Colors.black` for text. Use `onSurface`, `onPrimary`, `onSecondary`.
- ❌ Use `primary` as page background.
- ❌ Use `error` as a decorative accent.

---

## 2. Quick reference table

| Role        | Typical use                                 | Foreground pair |
| ----------- | ------------------------------------------- | --------------- |
| `primary`   | Main CTA buttons, active states, highlights | `onPrimary`     |
| `secondary` | Secondary actions, chips, badges, accents   | `onSecondary`   |
| `surface`   | Scaffold, cards, sheets, dialogs, app bars  | `onSurface`     |
| `error`     | Validation/error text, destructive actions  | `onError`       |

---

## 3. Snippet: ready-to-use helpers

```dart
extension ThemeContext on BuildContext {
  ThemeData get themeData => Theme.of(this);
  ColorScheme get colorScheme => themeData.colorScheme;
  TextTheme get textTheme => themeData.textTheme;
}

// Usage:
FilledButton(
  style: FilledButton.styleFrom(
    backgroundColor: context.colorScheme.primary,
    foregroundColor: context.colorScheme.onPrimary,
  ),
  onPressed: () {},
  child: const Text('Pay now'),
);

## 4. ColorScheme in `EcColors`

`EcColors` defines two schemes:

```dart
// Light
static ColorScheme light(ECThemeType app) => switch (app) {
    ECThemeType.user => const ColorScheme(
        brightness: Brightness.light,
        primary: EcLightPalette.ecRed,
        onPrimary: EcLightPalette.ecWhite,
        secondary: EcLightPalette.ecBlack,
        onSecondary: EcLightPalette.ecWhite,
        error: EcLightPalette.ecError,
        onError: EcLightPalette.ecWhite,
        surface: EcLightPalette.ecGrey,
        onSurface: EcLightPalette.ecWhite,
        outline: EcLightPalette.ecGrey,
        primaryContainer: EcLightPalette.ecWhite,
        ),
    ECThemeType.admin => const ColorScheme(
        brightness: Brightness.light,
        primary: EcLightPalette.ecOrange,
        onPrimary: EcLightPalette.ecWhite,
        secondary: EcLightPalette.ecBlack,
        onSecondary: EcLightPalette.ecWhite,
        error: EcLightPalette.ecError,
        onError: EcLightPalette.ecWhite,
        surface: EcLightPalette.ecGrey,
        onSurface: EcLightPalette.ecWhite,
        outline: EcLightPalette.ecGrey,
        primaryContainer: EcLightPalette.ecWhite,
        ),
    };

// Dark
static ColorScheme dark(ECThemeType app) => switch (app) {
    ECThemeType.user => const ColorScheme(
        brightness: Brightness.dark,
        primary: EcDarkPalette.ecRed,
        onPrimary: EcDarkPalette.ecWhite,
        secondary: EcDarkPalette.ecBlack,
        onSecondary: EcDarkPalette.ecWhite,
        error: EcDarkPalette.ecError,
        onError: EcDarkPalette.ecWhite,
        surface: EcDarkPalette.ecGrey,
        onSurface: EcDarkPalette.ecWhite,
        outline: EcDarkPalette.ecGrey,
        primaryContainer: EcDarkPalette.ecWhite,
        ),
    ECThemeType.admin => const ColorScheme(
        brightness: Brightness.dark,
        primary: EcDarkPalette.ecOrange,
        onPrimary: EcDarkPalette.ecWhite,
        secondary: EcDarkPalette.ecBlack,
        onSecondary: EcDarkPalette.ecWhite,
        error: EcDarkPalette.ecError,
        onError: EcDarkPalette.ecWhite,
        surface: EcDarkPalette.ecGrey,
        onSurface: EcDarkPalette.ecWhite,
        outline: EcDarkPalette.ecGrey,
        primaryContainer: EcDarkPalette.ecWhite,
        ),
    };
```

Attach to your app:

```dart
MaterialApp(
  theme: ThemeData(colorScheme: EcColors.light, useMaterial3: true),
  darkTheme: ThemeData(colorScheme: EcColors.dark, useMaterial3: true),
  themeMode: ThemeMode.system,
);
```

---

## 5. What each color is for (with examples)

### `primary` — your main brand/action color
- **Use for:** primary actions, filled buttons, active states, focused inputs, prominent chips, selected icons.
- **Avoid:** painting large backgrounds (use `surface`) or low-emphasis text.

**Examples**
```dart
// Elevated / Filled button
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: context.colorSchemeprimary,
    foregroundColor: context.colorSchemeonPrimary,
  ),
  onPressed: () {},
  child: const Text('Continue'),
);

// Active icon / selection
Icon(Icons.favorite, color: context.colorSchemeprimary);
```

### `onPrimary` — content placed on top of `primary`
- **Use for:** text, icons, and overlays that sit **on** a `primary` background.
- **Rule:** always pair `foregroundColor: onPrimary` when `backgroundColor: primary`.

**Example**
```dart
Chip(
  label: const Text('Hot'),
  labelStyle: TextStyle(color: context.colorSchemeonPrimary),
  backgroundColor: context.colorSchemeprimary,
);
```

---

### `secondary` — accent/supporting color
- **Use for:** lower-emphasis actions, filter chips, badges, secondary buttons, decorative accents.
- **Avoid:** replacing `primary` for your main CTA.

**Examples**
```dart
// Secondary button (TextButton that looks branded)
TextButton(
  style: TextButton.styleFrom(
    foregroundColor: context.colorScheme.secondary, // text/icon
  ),
  onPressed: () {},
  child: const Text('Learn more'),
);

// Badge / accent
Container(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  decoration: BoxDecoration(
    color: context.colorSchemesecondary,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text('BETA', style: TextStyle(color: context.colorSchemeonSecondary)),
);
```

### `onSecondary` — content placed on top of `secondary`
- **Use for:** text/icons inside `secondary`-colored elements.

**Example**
```dart
FilledButton.tonal(
  style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(context.colorSchemesecondary),
    foregroundColor: MaterialStatePropertyAll(context.colorSchemeonSecondary),
  ),
  onPressed: () {},
  child: const Text('Try demo'),
);
```

---

### `surface` — UI surfaces & containers
- **Use for:** page backgrounds, cards, sheets, dialogs, app bars, drawers, list tiles.
- **Avoid:** using `primary` as page background; it hurts readability.

**Examples**
```dart
Scaffold(
  backgroundColor: context.colorSchemesurface,
  appBar: AppBar(
    backgroundColor: context.colorSchemesurface,
    foregroundColor: context.colorSchemeonSurface,
    title: const Text('Account'),
  ),
  body: Card(
    color: context.colorSchemesurface,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Text('Hello', style: TextStyle(color: context.colorSchemeonSurface)),
    ),
  ),
);
```

### `onSurface` — content on top of `surface`
- **Use for:** default text and icons on cards, scaffolds, sheets, dialogs.

**Examples**
```dart
ListTile(
  title: Text('Username', style: TextStyle(color: context.colorSchemeonSurface)),
  subtitle: Text('john@doe.com', style: TextStyle(color: context.colorSchemeonSurface.withOpacity(.7))),
  leading: Icon(Icons.person, color: context.colorSchemeonSurface),
);
```

---

### `error` — destructive/invalid states
- **Use for:** error text, validation, destructive actions (e.g., delete), critical banners.
- **Avoid:** using as a general accent color.

**Examples**
```dart
// Error text
Text('Invalid email', style: TextStyle(color: context.colorSchemeerror));

// Destructive action
OutlinedButton.icon(
  icon: const Icon(Icons.delete_forever),
  style: OutlinedButton.styleFrom(foregroundColor: context.colorSchemeerror),
  onPressed: () {},
  label: const Text('Delete'),
);
```

### `onError` — content placed on top of `error`
- **Use for:** text/icons inside error-colored components.

**Example**
```dart
SnackBar(
  backgroundColor: context.colorSchemeerror,
  content: Text('Failed to save', style: TextStyle(color: context.colorSchemeonError)),
);
```

---

### `brightness` — tells Flutter how to treat the scheme
- **Use for:** letting the framework compute contrasts and defaults suitable for **light** or **dark** themes.
- **Rule:** Match your actual surfaces—if you pass `Brightness.dark`, ensure your surfaces are truly dark.

---

## 6. Common patterns

### AppBar
```dart
AppBar(
  backgroundColor: context.colorScheme.surface,
  foregroundColor: context.colorScheme.onSurface,
  // or use brand look:
  // backgroundColor: context.colorScheme.primary,
  // foregroundColor: context.colorScheme.onPrimary,
);
```

### Inputs & validation
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    errorText: hasError ? 'Invalid email' : null,
  ),
  cursorColor: context.colorScheme.primary,
);
```

### Cards / Containers
```dart
Card(
  color: context.colorScheme.surface,
  child: ListTile(
    title: Text('Order #1001', style: TextStyle(color: context.colorScheme.onSurface)),
  ),
);
```

### Buttons (rule of thumb)
- Filled / primary action → `background: primary`, `foreground: onPrimary`
- Secondary / quieter action → `foreground: secondary`
- Destructive action → `foreground/background: error` with `onError` for content

---
