# Color Scheme Guide

## Overview

This guide documents the color system used in the e-commerce Flutter application. The app supports both light and dark themes with separate color palettes for user and admin interfaces.

## Color System Architecture

The color system is organized into three main components:

1. **Light Palette** (`EcLightPalette`) - Colors optimized for light theme
2. **Dark Palette** (`EcDarkPalette`) - Colors optimized for dark theme  
3. **App Colors** (`EcColors`) - Theme-aware color schemes for different app types

## Color Palettes

### Base Colors

Each palette defines 7 primary colors with Material Design color variations (50-900):

- **Red** - Primary brand color for user interface
- **Orange** - Primary brand color for admin interface
- **Error** - Error states and validation feedback
- **White** - Backgrounds and light surfaces
- **Green** - Success states and positive actions
- **Grey** - Neutral surfaces and borders
- **Black** - Text and dark surfaces

### Color Scale (50-900)

Each color follows Material Design's color scale:

- **50** - Lightest shade (backgrounds, subtle accents)
- **100** - Very light shade
- **200** - Light shade
- **300** - Medium-light shade
- **400** - Medium shade
- **500** - Base color (primary shade)
- **600** - Medium-dark shade
- **700** - Dark shade
- **800** - Very dark shade
- **900** - Darkest shade (text, strong accents)

## Light Theme Palette

### Primary Colors
- **Red (Primary)**: `#DB3022` - Main brand color for user interface
- **Orange (Primary)**: `#F27D00` - Main brand color for admin interface
- **Error**: `#f01f0e` - Error states and validation

### Neutral Colors
- **White**: `#FFFFFF` - Pure white for backgrounds
- **Grey**: `#9B9B9B` - Neutral surfaces and borders
- **Black**: `#222222` - Text and dark elements

### Success Color
- **Green**: `#2AA952` - Success states and positive actions

## Dark Theme Palette

### Primary Colors
- **Red (Primary)**: `#e2594e` - Adjusted for dark theme visibility
- **Orange (Primary)**: `#f59733` - Adjusted for dark theme visibility
- **Error**: `#f34c3e` - Error states optimized for dark backgrounds

### Neutral Colors
- **White**: `#FFFFFF` - Pure white for text and highlights
- **Grey**: `#afafaf` - Neutral surfaces optimized for dark theme
- **Black**: `#4e4e4e` - Dark surfaces and containers

### Success Color
- **Green**: `#55ba75` - Success states optimized for dark backgrounds

## Theme Types

The app supports two different theme types with distinct color schemes:

### User Theme (`ECThemeType.user`)
- **Primary**: Red (`#DB3022` light, `#e2594e` dark)
- **Secondary**: Black (`#222222` light, `#4e4e4e` dark)
- **Surface**: Grey (`#9B9B9B` light, `#afafaf` dark)

### Admin Theme (`ECThemeType.admin`)
- **Primary**: Orange (`#F27D00` light, `#f59733` dark)
- **Secondary**: Black (`#222222` light, `#4e4e4e` dark)
- **Surface**: Grey (`#9B9B9B` light, `#afafaf` dark)

## Usage Guidelines

### Primary Colors
- Use primary colors for main actions, buttons, and brand elements
- Red for user-facing features (shopping, browsing)
- Orange for admin features (management, analytics)

### Secondary Colors
- Use secondary colors for supporting elements and text
- Black provides good contrast against light backgrounds
- White provides good contrast against dark backgrounds

### Surface Colors
- Grey surfaces work well for cards, containers, and dividers
- Provides subtle depth without overwhelming the interface

### Error Colors
- Use error colors sparingly for validation messages and error states
- Ensure sufficient contrast with background colors

### Success Colors
- Use green for successful actions, confirmations, and positive feedback
- Provides clear visual confirmation for user actions

## Implementation

### Using Colors in Widgets

```dart
// Access theme colors
final colors = Theme.of(context).colorScheme;

// Use primary color
Container(
  color: colors.primary,
  child: Text('Primary Action', style: TextStyle(color: colors.onPrimary)),
)

// Use surface color
Card(
  color: colors.surface,
  child: Text('Card Content', style: TextStyle(color: colors.onSurface)),
)
```

### Creating Custom Color Schemes

```dart
// For user theme
final userColors = EcColors.light(ECThemeType.user);

// For admin theme  
final adminColors = EcColors.dark(ECThemeType.admin);
```

## Accessibility Considerations

### Contrast Ratios
- All color combinations meet WCAG AA contrast requirements
- Primary colors provide sufficient contrast with their on-colors
- Error and success colors are distinguishable in both themes


## Best Practices

1. **Consistency**: Use the defined color palette consistently across the app
2. **Semantic Meaning**: Use colors for their intended semantic purpose
3. **Theme Awareness**: Always consider both light and dark themes
4. **Accessibility**: Test color combinations for sufficient contrast
5. **Brand Identity**: Maintain brand consistency through primary color usage

## Color Naming Convention

- Use descriptive names that indicate purpose (e.g., `ecRed`, `ecError`)
- Follow the `ec` prefix convention for brand colors
- Use Material Design color scale (50-900) for variations
- Maintain consistent naming across light and dark palettes