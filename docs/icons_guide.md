# Custom Icons Guide

## Quick Start

### 1. Import and Use

```dart
import 'package:ec_design/ec_design.dart';

// Basic usage
Icon(EcDesignIcons.icArrowLeft)

// With custom properties
Icon(EcDesignIcons.icArrowRight, size: 24, color: Colors.blue)
```

### 2. Font Configuration

Font is already configured in `e_commerce_app/pubspec.yaml`:

```yaml
flutter:
  fonts:
    - family: e_commerce_icon
      fonts:
        - asset: ../packages/ec_design/assets/icons/e_commerce_icon.ttf
```

### 3. Available Icons

All icons are defined in `packages/ec_design/lib/themes/icons.dart`:

```dart
class EcDesignIcons {
  static const IconData icArrowLeft = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData icArrowRight = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData icShoppingBag = IconData(0xe903, fontFamily: _fontFamily);
  // ... more icons
}
```

## Adding/Changing Icons via JSON

### What is e_commerce_icon.json?

The `e_commerce_icon.json` file is the **source of truth** for your icon font. It defines:

- Icon names, codes, and descriptions
- Font settings and configuration
- Which icons are included in the font

**Location**: `packages/ec_design/assets/icons/e_commerce_icon.json`

### Workflow: Add/Change Icons

#### **1. Prepare Icons**

- Create SVG icons (24x24 or 32x32 pixels)
- Use simple, clean designs
- Follow consistent style guidelines

#### **2. Use Icon Generator**

- **IcoMoon**: <https://icomoon.io/> (free, web-based)

#### **3. Import and Configure**

1. Upload your SVG files
2. Import existing `e_commerce_icon.json` to restore current set
3. Add new icons or modify existing ones
4. Set font configuration:

```json
{
  "name": "e_commerce_icon",
  "css_prefix_text": "ic",
  "hinting": true
}
```

#### **4. Generate and Update**

1. Click "Generate Font"
2. Download the package
3. Replace files in your project:

   - `packages/ec_design/assets/icons/e_commerce_icon.ttf`
   - `packages/ec_design/assets/icons/e_commerce_icon.json`

4. Update `icons.dart` if adding new icons:

```dart
static const IconData icNewIcon = IconData(0xe921, fontFamily: _fontFamily);
```

### JSON Structure Example

```json
{
  "name": "e_commerce_icon",
  "css_prefix_text": "ic",
  "icons": [
    {
      "name": "icArrowLeft",
      "code": "e900",
      "description": "Left arrow icon"
    },
    {
      "name": "icShoppingBag",
      "code": "e901",
      "description": "Shopping bag icon"
    }
  ]
}
```

### Naming Convention

- **Format**: `ic + Category + SpecificName + Variant`
- **Examples**:

  - `icArrowLeft`, `icArrowRight`
  - `icShoppingBag`, `icHeartFilled`
  - `icStarOutlined`, `icHomeActive`

### Troubleshooting

- **Icons not showing**: Run `flutter clean` and rebuild
- **Wrong icons**: Check Unicode codes match between JSON and Dart
- **Font issues**: Verify TTF file path in pubspec.yaml

---

*This guide focuses on the JSON-based workflow for managing custom icons in your Flutter e-commerce app.*
