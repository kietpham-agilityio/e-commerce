# Color Scheme Guide

## Overview

The e-commerce app uses a comprehensive color system built with Flutter's Material Design principles. The color scheme supports both light and dark themes, with separate user and admin interfaces.

## Architecture

The color system consists of three main components:

1. **Light Palette** (`EcLightPalette`) - Color definitions for light theme
2. **Dark Palette** (`EcDarkPalette`) - Color definitions for dark theme  
3. **App Colors** (`EcColors`) - Theme configuration and ColorScheme generation

## Color Palettes

### Base Colors

The system defines five primary color families, each with 10 shades (50-900):

#### 1. Red (`ecRed`)
- **Primary brand color** for user interface
- Base: `#DB3022` (shade 500)
- Used for: Primary actions, brand elements, user interface

#### 2. Orange (`ecOrange`) 
- **Primary brand color** for admin interface
- Base: `#F27D00` (shade 500)
- Used for: Admin interface, secondary actions

#### 3. White (`ecWhite`)
- **Background and surface colors**
- Light theme base: `#FFFFFF` (shade 500)
- Dark theme base: `#121212` (shade 500)
- Used for: Backgrounds, cards, surfaces

#### 4. Green (`ecGreen`)
- **Success and positive states**
- Base: `#2AA952` (shade 500)
- Used for: Success messages, confirmations, positive actions

#### 5. Grey (`ecGrey`)
- **Neutral and text colors**
- Light theme base: `#9B9B9B` (shade 500)
- Dark theme base: `#B3B3B3` (shade 500)
- Used for: Text, borders, disabled states

#### 6. Black (`ecBlack`)
- **Text and emphasis colors**
- Light theme base: `#222222` (shade 900)
- Dark theme base: `#000000` (shade 50)
- Used for: Primary text, emphasis, contrast

## Shade System

Each color follows Material Design's 10-shade system:

- **50**: Lightest shade (backgrounds, subtle highlights)
- **100-300**: Light shades (borders, subtle elements)
- **400-500**: Base/primary shades (main colors)
- **600-700**: Darker shades (shadows, emphasis)
- **800-900**: Darkest shades (text, strong emphasis)

## Theme Types

The app supports two distinct theme types:

### 1. User Theme (`ECThemeType.user`)
- **Primary**: Red (`#DB3022`)
- **Target**: End users, customers
- **Usage**: Main shopping interface, product browsing

### 2. Admin Theme (`ECThemeType.admin`)
- **Primary**: Orange (`#F27D00`)
- **Target**: Administrators, staff
- **Usage**: Management interface, order processing

## ColorScheme Configuration

### Light Theme

```dart
ColorScheme(
  brightness: Brightness.light,
  primary: EcLightPalette.ecRed[500]!,            // #DB3022
  onPrimary: EcLightPalette.ecWhite[500]!,        // #FFFFFF
  secondary: EcLightPalette.ecBlack[900]!,        // #222222
  onSecondary: EcLightPalette.ecWhite,            // #FFFFFF
  error: EcLightPalette.ecRed[700]!,              // #F01F0E
  onError: EcLightPalette.ecWhite[500]!,          // #FFFFFF
  surface: EcLightPalette.ecGrey[500]!,           // #9B9B9B
  onSurface: EcLightPalette.ecWhite[500]!,        // #FFFFFF
  outline: EcLightPalette.ecGrey[500],            // #9B9B9B
  primaryContainer: EcLightPalette.ecWhite[500]!, // #FFFFFF
)
```

### Dark Theme

```dart
ColorScheme(
  brightness: Brightness.dark,
  primary: EcDarkPalette.ecRed[500]!,            // #DB3022
  onPrimary: EcDarkPalette.ecWhite[900]!,        // #FFFFFF
  secondary: EcDarkPalette.ecBlack[50]!,         // #000000
  onSecondary: EcDarkPalette.ecWhite[900]!,      // #FFFFFF
  error: EcDarkPalette.ecRed[200]!,              // #F01F0E
  onError: EcDarkPalette.ecWhite[900]!,          // #FFFFFF
  surface: EcDarkPalette.ecGrey[50]!,            // #1C1C1C
  onSurface: EcDarkPalette.ecWhite[900]!,        // #FFFFFF
  outline: EcDarkPalette.ecGrey[500]!,           // #B3B3B3
  primaryContainer: EcDarkPalette.ecWhite[100]!, // #1E1E1E
)
```

## Custom Shadows

The system provides custom shadow colors through extensions:

### `shadowPrimary(ECThemeType app)`
- **User theme**: Red shadows for light/dark modes
- **Admin theme**: Orange shadows for light/dark modes

### `shadowPrimaryContainer(ECThemeType app)`
- Provides appropriate shadow colors for primary containers
- Adapts to both light and dark themes

## Usage Guidelines

### 1. Primary Colors
- Use red (`ecRed`) for user interface elements
- Use orange (`ecOrange`) for admin interface elements
- Apply to: Buttons, links, active states, brand elements

### 2. Background Colors
- **Light theme**: Use white shades (50-400) for backgrounds
- **Dark theme**: Use dark grey shades (50-400) for backgrounds
- Maintain proper contrast ratios (4.5:1 minimum)

### 3. Text Colors
- **Primary text**: Use black (light) or white (dark) shades
- **Secondary text**: Use grey shades for less emphasis
- **Error text**: Use red shades for validation messages

### 4. Interactive Elements
- **Buttons**: Use primary colors with appropriate onPrimary colors
- **Links**: Use primary colors or secondary colors
- **Borders**: Use grey shades for subtle boundaries

### 5. State Colors
- **Success**: Green shades for positive feedback
- **Error**: Red shades for errors and warnings
- **Disabled**: Grey shades for inactive elements

## Implementation Example

```dart
// Get theme-aware colors
final colors = Theme.of(context).colorScheme;
final appType = ECThemeType.user; // or admin

// Use primary colors
Container(
  color: colors.primary,
  child: Text(
    'Primary Button',
    style: TextStyle(color: colors.onPrimary),
  ),
)

// Use custom shadows
BoxShadow(
  color: colors.shadowPrimary(appType),
  blurRadius: 8,
  offset: Offset(0, 4),
)
```

## Accessibility Considerations

1. **Contrast Ratios**: Ensure text meets WCAG AA standards (4.5:1)
2. **Color Independence**: Don't rely solely on color to convey information
3. **Dark Mode Support**: All colors have appropriate dark theme alternatives
4. **Semantic Colors**: Use consistent color meanings across the app

## Best Practices

1. **Consistency**: Use the defined color palette consistently
2. **Semantic Meaning**: Assign colors based on their purpose, not appearance
3. **Theme Switching**: Test both light and dark themes thoroughly
4. **Color Combinations**: Ensure proper contrast between adjacent colors
5. **Brand Identity**: Maintain red/orange distinction between user/admin interfaces

## Future Considerations

- Consider adding more semantic color tokens (info, warning, etc.)
- Evaluate color accessibility with real user testing
- Monitor color usage patterns for optimization opportunities
- Consider adding color variants for different product categories
