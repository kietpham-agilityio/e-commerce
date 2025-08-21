# Typography Guide (Flutter)

This guide explains **how to use the `EcTypography` system** and **how it's implemented in the AppTheme** for consistent typography across your e-commerce application.

---

## 📋 Quick Summary

### **What is EcTypography?**

A comprehensive typography system built around the **Metropolis** font family that provides consistent text styles for your entire app.

### **Key Principles**

- ✅ **Never hardcode text styles** - always use `EcTypography` or theme
- ✅ **Consistency first** - use established typography scale
- ✅ **Theme integration** - automatic color adaptation for light/dark modes

### **Available Styles (18 total)**

- **Display**: `displayLarge`, `displayMedium`, `displaySmall` (hero content)
- **Headline**: `headlineLarge`, `headlineMedium`, `headlineSmall` (page titles)
- **Title**: `titleLarge`, `titleMedium`, `titleSmall` (card titles)
- **Body**: `bodyLarge`, `bodyMedium`, `bodySmall` (main content)
- **Label**: `labelLarge`, `labelMedium`, `labelSmall` (form labels)
- **Special**: `caption`, `overline`, `button` (specific UI elements)

### **Quick Usage**

```dart
// Direct usage
Text('Hero Title', style: EcTypography.displayLarge)

// Theme-based usage
Text('Page Title', style: Theme.of(context).textTheme.headlineLarge)

// With custom color
Text('Custom Text', style: EcTypography.bodyMedium.copyWith(color: Colors.blue))
```

### **Font Scale**

- **Base**: 14px (default body text)
- **Range**: 10px (xs) to 48px (massive)
- **Weights**: Regular (400), Medium (500), SemiBold (600), Bold (700)

---

## 📚 Detailed Guide

### **1. Font Family & Weights**

#### Font Family

- **Primary Font**: `Metropolis` (custom font family)
- **Usage**: Automatically applied to all typography styles
- **Access**: `EcTypography.fontFamily`

#### Font Weights

```dart
// Available weights (mapped to Metropolis font files)
static const FontWeight regular = FontWeight.w400;    // Metropolis-Regular.otf
static const FontWeight medium = FontWeight.w500;     // Metropolis-Medium.otf (default)
static const FontWeight semiBold = FontWeight.w600;   // Metropolis-SemiBold.otf
static const FontWeight bold = FontWeight.w700;       // Metropolis-Bold.otf
```

### **2. Typography Scale**

#### Font Sizes

```dart
// Size constants (in logical pixels)
static const double xs = 10.0;      // Extra small
static const double sm = 12.0;      // Small
static const double base = 14.0;    // Base (default body text)
static const double lg = 16.0;      // Large
static const double xl = 18.0;      // Extra large
static const double xxl = 20.0;     // 2x large
static const double xxxl = 24.0;    // 3x large
static const double huge = 30.0;    // Huge
static const double giant = 34.0;   // Giant
static const double massive = 48.0; // Massive
```

#### Line Heights

```dart
// Line height multipliers
static const double tightHeight = 1.25;      // Compact spacing
static const double normalHeight = 1.5;      // Standard spacing
static const double relaxedHeight = 1.75;    // Comfortable reading
```

#### Letter Spacing

```dart
// Letter spacing (in logical pixels)
static const double tightSpacing = -0.5;     // Tighter spacing
static const double normalSpacing = 0.0;     // Default spacing
static const double wideSpacing = 0.5;       // Wider spacing
```

### **3. Typography Styles**

#### Display Styles

Used for hero content and large headlines:

```dart
// Hero titles (48px, bold, tight spacing)
EcTypography.displayLarge

// Section headers (34px, bold, tight spacing)
EcTypography.displayMedium

// Subsection headers (30px, semi-bold, tight spacing)
EcTypography.displaySmall
```

#### Headline Styles

Used for page and section titles:

```dart
// Main page titles (24px, semi-bold)
EcTypography.headlineLarge

// Page titles (20px, semi-bold)
EcTypography.headlineMedium

// Section titles (18px, semi-bold)
EcTypography.headlineSmall
```

#### Title Styles

Used for card and list item titles:

```dart
// Card titles (16px, medium weight)
EcTypography.titleLarge

// List item titles (14px, medium weight)
EcTypography.titleMedium

// Small titles (12px, medium weight)
EcTypography.titleSmall
```

#### Body Styles

Used for main content and reading text:

```dart
// Main content (16px, regular weight, relaxed height)
EcTypography.bodyLarge

// Regular content (14px, regular weight, relaxed height)
EcTypography.bodyMedium

// Secondary content (12px, regular weight, relaxed height)
EcTypography.bodySmall
```

#### Label Styles

Used for form labels and UI elements:

```dart
// Form labels (14px, medium weight)
EcTypography.labelLarge

// Small labels (14px, medium weight)
EcTypography.labelMedium

// Tiny labels (10px, medium weight)
EcTypography.labelSmall
```

#### Special Styles

Used for specific UI elements:

```dart
// Captions and metadata (10px, regular weight)
EcTypography.caption

// Overlines and small text (10px, medium weight)
EcTypography.overline

// Button labels (14px, medium weight)
EcTypography.button
```

### **4. Implementation in AppTheme**

#### Theme Integration

The `EcTypography` system is fully integrated into your app's theme through `EcDesignTheme`:

```dart
class EcDesignTheme {
  /// Light theme for the e-commerce app
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: EcColors.light(ECThemeType.user),
      useMaterial3: true,
      fontFamily: EcTypography.fontFamily,  // Uses Metropolis font
      textTheme: _buildTextTheme(ECThemeType.user, false),
    );
  }

  /// Dark theme for the e-commerce app
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: EcColors.dark(ECThemeType.user),
      useMaterial3: true,
      fontFamily: EcTypography.fontFamily,  // Uses Metropolis font
      textTheme: _buildTextTheme(ECThemeType.user, true),
    );
  }
}
```

#### Text Theme Building

The theme automatically builds a `TextTheme` that maps Material Design text styles to your `EcTypography` styles:

```dart
static TextTheme _buildTextTheme(ECThemeType themeType, bool isDark) {
  final colors = isDark 
      ? EcColors.dark(themeType) 
      : EcColors.light(themeType);
  
  return TextTheme(
    // Display styles
    displayLarge: EcTypography.displayLarge.copyWith(color: colors.secondary),
    displayMedium: EcTypography.displayMedium.copyWith(color: colors.secondary),
    displaySmall: EcTypography.displaySmall.copyWith(color: colors.secondary),

    // Headline styles
    headlineLarge: EcTypography.headlineLarge.copyWith(color: colors.secondary),
    headlineMedium: EcTypography.headlineMedium.copyWith(color: colors.secondary),
    headlineSmall: EcTypography.headlineSmall.copyWith(color: colors.secondary),

    // Title styles
    titleLarge: EcTypography.titleLarge.copyWith(color: colors.secondary),
    titleMedium: EcTypography.titleMedium.copyWith(color: colors.secondary),
    titleSmall: EcTypography.titleSmall.copyWith(color: colors.secondary),

    // Body styles
    bodyLarge: EcTypography.bodyLarge.copyWith(color: colors.secondary),
    bodyMedium: EcTypography.bodyMedium.copyWith(color: colors.secondary),
    bodySmall: EcTypography.bodySmall.copyWith(color: colors.outline),

    // Label styles
    labelLarge: EcTypography.labelLarge.copyWith(color: colors.secondary),
    labelMedium: EcTypography.labelMedium.copyWith(color: colors.secondary),
    labelSmall: EcTypography.labelSmall.copyWith(color: colors.secondary),
  );
}
```

### **5. Usage Guidelines**

#### Do's ✅

- ✅ Use `EcTypography` styles directly for custom text styling
- ✅ Read from `Theme.of(context).textTheme` for standard Material Design text styles
- ✅ Use the theme-aware methods for dynamic color adaptation
- ✅ Maintain consistent typography hierarchy across your app

#### Don'ts ❌

- ❌ Don't hardcode font sizes, weights, or families
- ❌ Don't create custom `TextStyle` objects that bypass the design system
- ❌ Don't mix different typography systems in the same app

### **6. Usage Examples**

#### Direct Typography Usage

```dart
import 'package:ec_design/ec_design.dart';

// Using EcTypography directly
Text(
  'Hero Title',
  style: EcTypography.displayLarge,
)

// With custom color
Text(
  'Custom Colored Text',
  style: EcTypography.headlineMedium.copyWith(color: Colors.blue),
)
```

#### Theme-Based Usage

```dart
// Reading from theme (automatically uses EcTypography styles)
Text(
  'Page Title',
  style: Theme.of(context).textTheme.headlineLarge,
)

// Body text
Text(
  'This is the main content of your app.',
  style: Theme.of(context).textTheme.bodyMedium,
)
```

#### Theme-Aware Typography

```dart
// Dynamic color adaptation based on theme
Text(
  'Adaptive Text',
  style: EcTypography.getDisplayLarge(ECThemeType.user, isDarkMode),
)
```

#### Utility Methods

```dart
// Customizing existing styles
Text(
  'Custom Style',
  style: EcTypography.withColor(
    EcTypography.bodyLarge,
    Colors.green,
  ),
)

// Custom weight
Text(
  'Bold Body Text',
  style: EcTypography.withWeight(
    EcTypography.bodyMedium,
    FontWeight.bold,
  ),
)
```

### **7. Best Practices**

#### 1. **Consistency First**

Always use the established typography scale. Don't create variations unless absolutely necessary.

#### 2. **Hierarchy Matters**

Use the appropriate style for the content's importance:

- **Display**: Hero content, main headlines
- **Headline**: Page titles, major sections
- **Title**: Card titles, list headers
- **Body**: Main content, descriptions
- **Label**: Form labels, UI elements

#### 3. **Color Integration**

Typography automatically integrates with your color scheme:

- Primary text uses `colors.secondary`
- Secondary text uses `colors.outline`
- Custom colors can override these defaults

#### 4. **Responsive Design**

The typography system is designed to work across different screen sizes and densities.

### **8. Customization**

#### Adding New Styles

If you need a new typography style, add it to `EcTypography` following the existing pattern:

```dart
/// Custom text style for special use cases
static TextStyle get customStyle => TextStyle(
  fontFamily: fontFamily,
  fontSize: base,
  fontWeight: medium,
  height: normalHeight,
  letterSpacing: normalSpacing,
  color: _defaultTextColor,
);
```

#### Modifying Existing Styles

Use the utility methods to modify existing styles:

```dart
// Change color
EcTypography.withColor(EcTypography.bodyMedium, Colors.red)

// Change weight
EcTypography.withWeight(EcTypography.titleLarge, FontWeight.bold)

// Change size
EcTypography.withSize(EcTypography.bodySmall, 16.0)
```

### **9. Troubleshooting**

#### Common Issues

**Text not using Metropolis font:**

- Ensure `EcTypography.fontFamily` is properly set
- Check that the font files are included in your `pubspec.yaml`

**Typography styles not applying:**

- Verify you're importing from the correct package
- Check that the theme is properly configured in your app

**Colors not adapting to theme:**

- Use theme-aware methods for dynamic color adaptation
- Ensure your color scheme is properly configured

### **10. Integration with Design System**

The `EcTypography` system is part of your larger design system and integrates with:

- **Color System**: Automatic color adaptation based on theme
- **Theme System**: Seamless integration with light/dark modes
- **Component Library**: Consistent typography across all UI components
- **Brand Guidelines**: Maintains brand consistency and visual hierarchy

---

## 🎯 Summary

The `EcTypography` system provides a robust foundation for consistent typography across your e-commerce application. By using these predefined styles and integrating them with your theme system, you ensure:

1. **Consistency**: All text follows the same design principles
2. **Maintainability**: Typography changes are centralized
3. **Accessibility**: Proper contrast and readability
4. **Brand Alignment**: Typography reflects your brand identity
5. **Developer Experience**: Easy-to-use, well-documented system

Remember: **Always use the design system typography** rather than creating custom text styles. This ensures your app maintains a professional, consistent appearance that aligns with your brand guidelines.
