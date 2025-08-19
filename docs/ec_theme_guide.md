# EcTheme Guide

## Overview

EcTheme is the comprehensive theming system for the e-commerce Flutter application. It provides a unified approach to managing themes, colors, and visual styling across different app types and device modes.

## Theme System Architecture

The EcTheme system consists of several interconnected components:

1. **Theme Types** - Different app interfaces (user, admin)
2. **Device Modes** - Light and dark theme support
3. **Color Palettes** - Comprehensive color system
4. **Design System Integration** - Consistent visual language

## Theme Types

### ECThemeType Enum

```dart
enum ECThemeType { user, admin }
```

- **`ECThemeType.user`** - Customer-facing interface (shopping, browsing, checkout)
- **`ECThemeType.admin`** - Administrative interface (management, analytics, settings)

## Device Modes

The system automatically adapts to the device's theme preference:

- **Light Mode** - Optimized for bright environments and daytime usage
- **Dark Mode** - Optimized for low-light environments and battery saving

## Color Palette

The color system is a core component of the design system. Each color has ten shades (50-900), with one marked as primary (500).

### Color Structure

- **50** - Lightest shade (backgrounds, subtle accents)
- **100-400** - Light to medium shades
- **500** - Primary shade (base color)
- **600-900** - Medium to darkest shades

### Base Colors

- **Red** - Primary brand color for user interface
- **Orange** - Primary brand color for admin interface
- **Error** - Error states and validation feedback
- **White** - Backgrounds and light surfaces
- **Green** - Success states and positive actions
- **Grey** - Neutral surfaces and borders
- **Black** - Text and dark surfaces

### Using Colors

**Important**: Always use `EcColors` instead of directly accessing palette colors. This ensures automatic theme adaptation:

```dart
// ✅ Correct - Automatically adapts to theme and device mode
final colors = Theme.of(context).colorScheme;
Container(color: colors.primary)

// ❌ Incorrect - Hardcoded colors don't adapt
Container(color: EcLightPalette.ecRed[500])
```

### Color Schemes

The system automatically provides appropriate color schemes:

```dart
// For user theme
final userColors = EcColors.light(ECThemeType.user);
final userDarkColors = EcColors.dark(ECThemeType.user);

// For admin theme
final adminColors = EcColors.light(ECThemeType.admin);
final adminDarkColors = EcColors.dark(ECThemeType.admin);
```

For detailed color information, see the [Color Scheme Guide](./color_scheme_guide.md).

## Design System Integration

The EcTheme system is built on top of a comprehensive design system that ensures:

- **Consistency** - Unified visual language across all components
- **Accessibility** - WCAG AA compliance for all color combinations
- **Scalability** - Easy addition of new themes and color variations
- **Maintainability** - Centralized theme management

## Implementation

### Basic Theme Usage

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: EcColors.light(ECThemeType.user),
        // Other theme properties...
      ),
      darkTheme: ThemeData(
        colorScheme: EcColors.dark(ECThemeType.user),
        // Other dark theme properties...
      ),
    );
  }
}
```

### Dynamic Theme Switching

```dart
// Switch between user and admin themes
void switchToAdminTheme() {
  final adminColors = EcColors.light(ECThemeType.admin);
  // Apply admin theme...
}
```

### Accessing Theme Colors

```dart
Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;
  
  return Container(
    color: colors.primary,
    child: Text(
      'Primary Text',
      style: TextStyle(color: colors.onPrimary),
    ),
  );
}
```

## Best Practices

1. **Always use EcColors** - Never hardcode palette colors
2. **Theme-aware components** - Design widgets that adapt to theme changes
3. **Consistent usage** - Use colors for their intended semantic purpose
4. **Accessibility first** - Ensure sufficient contrast in all themes
5. **Design system compliance** - Follow established visual patterns

## Theme Customization

### Adding New Theme Types

```dart
enum ECThemeType { user, admin, partner }

// Extend EcColors class
static ColorScheme partner(ECThemeType app) => switch (app) {
  ECThemeType.partner => const ColorScheme(
    // Define partner theme colors...
  ),
  // ... other cases
};
```

### Custom Color Schemes

```dart
// Create custom color schemes while maintaining design system compliance
final customColors = ColorScheme(
  brightness: Brightness.light,
  primary: EcLightPalette.ecRed,
  // ... other color properties
);
```

## Testing

### Theme Testing

```dart
testWidgets('Widget adapts to theme changes', (tester) async {
  // Test with light theme
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData(
        colorScheme: EcColors.light(ECThemeType.user),
      ),
      home: MyWidget(),
    ),
  );
  
  // Verify light theme colors
  
  // Test with dark theme
  await tester.pumpWidget(
    MaterialApp(
      darkTheme: ThemeData(
        colorScheme: EcColors.dark(ECThemeType.user),
      ),
      home: MyWidget(),
    ),
  );
  
  // Verify dark theme colors
});
```

## Troubleshooting

### Common Issues

1. **Colors not adapting** - Ensure you're using `Theme.of(context).colorScheme`
2. **Theme not switching** - Check that both `theme` and `darkTheme` are set
3. **Inconsistent appearance** - Verify all components use theme colors

### Debug Mode

Enable theme debugging to see which colors are being used:

```dart
// Add debug information to see current theme
print('Current theme: ${Theme.of(context).colorScheme}');
```

## Related Documentation

- [Color Scheme Guide](./color_scheme_guide.md) - Detailed color palette information
