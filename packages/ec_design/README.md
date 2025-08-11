# EC Design Package

## 📦 Purpose

The `ec_design` package is the **design system** for the e-commerce app. It contains all the visual components, themes, icons, and design tokens that ensure consistency across the entire application.

### What's included:
- 🎨 **Themes**: Color schemes, typography, and design tokens
- 🎯 **Icons**: Custom icon font with e-commerce specific icons
- 🧩 **Components**: Reusable UI components (coming soon)
- 📚 **Widgetbook**: Interactive component documentation (coming soon)

---

## 🚀 Installation

### For Local Development

Since this is a local package in your e-commerce project, you don't need to install it from pub.dev. It's already configured in your main app.

1. **Check your main app's `pubspec.yaml`**:
```yaml
dependencies:
  ec_design:
    path: ../packages/ec_design
```

2. **Run pub get** (if you haven't already):
```bash
flutter pub get
```

### For External Projects

If you want to use this package in another project:

1. **Add to `pubspec.yaml`**:
```yaml
dependencies:
  ec_design:
    git:
      url: https://github.com/your-org/e-commerce.git
      path: packages/ec_design
```

2. **Run pub get**:
```bash
flutter pub get
```

---

## 🎯 Usage

### Basic Setup

1. **Import the package** in your Dart file:
```dart
import 'package:ec_design/ec_design.dart';
```

2. **Use themes** in your app:
```dart
import 'package:flutter/material.dart';
import 'package:ec_design/ec_design.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: EcDesignTheme.lightTheme, // Use the design system theme
      home: MyHomePage(),
    );
  }
}
```

### Using Icons

The package includes custom e-commerce icons:

```dart
import 'package:ec_design/ec_design.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Basic icon
        Icon(EcDesignIcons.icArrowLeft),
        
        // Icon with custom size and color
        Icon(
          EcDesignIcons.icHeart,
          size: 24,
          color: Colors.red,
        ),
        
        // Icon in a button
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(EcDesignIcons.icShoppingBag),
          label: Text('Add to Cart'),
        ),
      ],
    );
  }
}
```

### Available Icons

Here are some of the icons you can use:

| Icon | Code | Description |
|------|------|-------------|
| `EcDesignIcons.icArrowLeft` | ← | Left arrow |
| `EcDesignIcons.icArrowRight` | → | Right arrow |
| `EcDesignIcons.icHeart` | ♥ | Heart |
| `EcDesignIcons.icShoppingBag` | 🛍️ | Shopping bag |
| `EcDesignIcons.icSearch` | 🔍 | Search |
| `EcDesignIcons.icHome` | 🏠 | Home |
| `EcDesignIcons.icProfile` | 👤 | Profile |
| `EcDesignIcons.icStar` | ⭐ | Star |

*For a complete list, check the `lib/themes/icons.dart` file.*

---

## 🔄 Updates

### How to Update the Package

1. **Check for changes** in the `packages/ec_design` directory
2. **Run pub get** in your main app:
```bash
cd e_commerce_app
flutter pub get
```

### Version Management

The package version is managed in `packages/ec_design/pubspec.yaml`:
```yaml
name: ec_design
version: 0.0.1  # This will be updated as features are added
```

### Breaking Changes

When breaking changes are made:
1. **Version bump** will be announced
2. **Migration guide** will be provided
3. **Deprecation warnings** will be shown

---

## 📁 Folder Structure

```
packages/ec_design/
├── 📄 pubspec.yaml              # Package configuration
├── 📄 README.md                 # This file
├── 📄 CHANGELOG.md              # Version history
├── 📁 lib/                      # Main source code
│   ├── 📄 ec_design.dart        # Main export file
│   └── 📁 themes/               # Theme definitions
│       ├── 📄 themes.dart       # Theme exports
│       └── 📄 icons.dart        # Icon definitions
├── 📁 assets/                   # Static assets
│   └── 📁 icons/                # Icon font files
│       └── 📄 e_commerce_icon.ttf
└── 📁 components/               # Coming soon
    ├── 📁 buttons/              # Button components
    ├── 📁 cards/                # Card components
    ├── 📁 inputs/               # Input components
    └── 📁 navigation/           # Navigation components
```

### Planned Structure

The package will be expanded to include:

```
packages/ec_design/
├── 📁 lib/
│   ├── 📁 themes/               # ✅ Current
│   │   ├── 📄 themes.dart
│   │   ├── 📄 icons.dart
│   │   ├── 📄 colors.dart       # 🔄 Coming soon
│   │   ├── 📄 typography.dart   # 🔄 Coming soon
│   │   └── 📄 spacing.dart      # 🔄 Coming soon
│   ├── 📁 components/           # 🔄 Coming soon
│   │   ├── 📁 buttons/
│   │   ├── 📁 cards/
│   │   ├── 📁 inputs/
│   │   └── 📁 navigation/
│   └── 📁 widgetbook/           # 🔄 Coming soon
│       ├── 📄 main.dart
│       └── 📁 stories/
```

---

## 🎨 Design System Principles

### Consistency
- All components follow the same design language
- Colors, spacing, and typography are standardized
- Icons use the same style and weight

### Accessibility
- Components meet WCAG guidelines
- Proper contrast ratios
- Screen reader support

### Performance
- Optimized icon font
- Efficient component rendering
- Minimal bundle size impact

---

## 🐛 Troubleshooting

### Common Issues

**Icons not showing:**
1. Make sure you imported the package: `import 'package:ec_design/ec_design.dart';`
2. Check that the font is configured in your app's `pubspec.yaml`
3. Run `flutter clean` and `flutter pub get`

**Theme not applying:**
1. Verify you're using `EcDesignTheme.lightTheme` or `EcDesignTheme.darkTheme`
2. Check that the theme is properly set in your `MaterialApp`

**Package not found:**
1. Ensure the path in `pubspec.yaml` is correct
2. Run `flutter pub get` in your main app directory
3. Check that the package exists in the specified path

---

## 🤝 Contributing

### Adding New Icons

1. **Create the icon** in SVG format
2. **Add to the font** using an icon generator (IcoMoon, Fontello)
3. **Update `icons.dart`** with the new icon definition
4. **Test** the icon in your app

### Adding New Components

1. **Create the component** in the appropriate folder
2. **Add documentation** and examples
3. **Update exports** in `ec_design.dart`
4. **Add to Widgetbook** for interactive documentation

### Reporting Issues

When reporting issues, please include:
- Flutter version
- Package version
- Steps to reproduce
- Expected vs actual behavior
- Screenshots (if applicable)

---

## 📚 Additional Resources

- [Flutter Design System Guide](https://docs.flutter.dev/ui/design)
- [Material Design Guidelines](https://material.io/design)
- [Icon Font Best Practices](https://icomoon.io/blog/icon-fonts-best-practices/)

---

## 📄 License

This package is part of the e-commerce project and follows the same license terms.

---

*This package is designed to make your e-commerce app development faster and more consistent. If you have questions or need help, don't hesitate to ask!*
