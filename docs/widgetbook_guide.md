# EC Widgetbook Documentation

A comprehensive guide for using and adding widgets to Widgetbook in the EC Design System.

## Table of Contents

1. [Overview](#overview)
2. [Getting Started](#getting-started)
3. [Using Widgetbook](#using-widgetbook)
4. [Adding New Widgets](#adding-new-widgets)
5. [Available Knobs](#available-knobs)
6. [Best Practices](#best-practices)
7. [Complete Examples](#complete-examples)
8. [Troubleshooting](#troubleshooting)

## Overview

Widgetbook is a powerful tool for creating documentation and testing Flutter widgets. It allows developers to:
- Preview widgets with different parameters
- Test widgets across various viewports and themes
- Copy code for immediate use
- Inspect and debug widgets in real-time

## Getting Started

### Prerequisites
- Flutter 3.29.2
- Dart 3.7.1
- Chrome browser (for web development)

### Installation
The Widgetbook package is already included in the project dependencies.

### Running Widgetbook
```bash
# Navigate to the widgetbook package directory
cd packages/ec_design/ec_widgetbook

# Run on Chrome
flutter run -d chrome
```

## Using Widgetbook

### Available Features
- **Viewport Addon**: Test on different screen sizes
- **Inspector Addon**: Inspect widget tree
- **Grid Addon**: Display grid for alignment
- **Alignment Addon**: Align widgets precisely
- **Zoom Addon**: Zoom in/out for detailed viewing
- **Theme Addon**: Switch between Light and Dark themes

### Navigation
- Use the left sidebar to navigate between widgets
- Select different use cases for each widget
- Adjust knobs to see real-time changes
- Copy code examples for immediate use

## Adding New Widgets

### Step 1: Create Widget File
Create a new file in `packages/ec_design/ec_widgetbook/lib/widget/` with the naming convention `your_widget_name.dart`:

```dart
import 'dart:developer';
import 'package:ec_themes/ec_design.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent yourWidgetWidgetbook() {
  return WidgetbookComponent(
    name: 'Your Widget Name',
    useCases: [
      WidgetbookUseCase(
        name: 'Basic Usage',
        builder: (context) {
          // Use knobs to create interactive controls
          final textKnob = context.knobs.string(
            label: 'Text',
            initialValue: 'Hello World',
          );
          
          final colorKnob = context.knobs.color(
            label: 'Color',
            initialValue: Colors.blue,
          );

          return ECUiWidgetbook(
            copyCode: '''
            YourWidget(
              text: '$textKnob',
              color: $colorKnob,
              onTap: () {
                // Your callback here
              },
            ),
            ''',
            child: YourWidget(
              text: textKnob,
              color: colorKnob,
              onTap: () {
                log('Widget tapped');
              },
            ),
          );
        },
      ),
    ],
  );
}
```

### Step 2: Register Widget in main.dart
Add the import and register your new widget in `main.dart`:

```dart
import 'package:ec_widgetbook/widget/your_widget_name.dart';

// In the WidgetbookApp build method
WidgetbookCategory(
  name: 'Widget',
  children: [
    exampleWidgetBooks(),
    yourWidgetWidgetbook(), // Add your new widget
  ],
),
```

### Step 3: Create Multiple Use Cases
Add different use cases to showcase various widget configurations:

```dart
WidgetbookUseCase(
  name: 'With Icon',
  builder: (context) {
    final iconKnob = context.knobs.object.dropdown(
      label: 'Icon',
      options: [
        Icon(EcDesignIcons.icArrowLeft),
        Icon(EcDesignIcons.icArrowRight),
        Icon(EcDesignIcons.icHome),
      ],
    );

    return ECUiWidgetbook(
      copyCode: '''
      YourWidget(
        icon: $iconKnob,
        onTap: () {
          // Your callback here
        },
      ),
      ''',
      child: YourWidget(
        icon: iconKnob,
        onTap: () {
          log('Widget with icon tapped');
        },
      ),
    );
  },
),
```

## Available Knobs

### String Knobs
```dart
final textKnob = context.knobs.string(
  label: 'Text Label',
  initialValue: 'Default Text',
  description: 'Optional description',
);
```

### Number Knobs
```dart
final numberKnob = context.knobs.double(
  label: 'Size',
  initialValue: 16.0,
  min: 8.0,
  max: 32.0,
);
```

### Boolean Knobs
```dart
final boolKnob = context.knobs.boolean(
  label: 'Enabled',
  initialValue: true,
);
```

### Color Knobs
```dart
final colorKnob = context.knobs.color(
  label: 'Background Color',
  initialValue: Colors.white,
);
```

### Dropdown Knobs
```dart
final dropdownKnob = context.knobs.object.dropdown(
  label: 'Type',
  options: ['Option 1', 'Option 2', 'Option 3'],
);
```

### Slider Knobs
```dart
final sliderKnob = context.knobs.double(
  label: 'Opacity',
  initialValue: 1.0,
  min: 0.0,
  max: 1.0,
);
```

>Refer: [document](https://docs.widgetbook.io/knobs/overview)

## Best Practices

### Use Case Organization
- Create a use case for each main usage scenario
- Use clear, descriptive names for use cases
- Utilize knobs to create interactive controls
- Keep use cases focused and specific

### Code Examples
- Provide clear, copyable code examples
- Use the `ECUiWidgetbook` wrapper for consistent UI
- Include the `copyCode` parameter for easy code copying
- Ensure examples are production-ready

### Performance Considerations
- Use `const` constructors when possible
- Avoid creating unnecessary objects in builders
- Use `ValueNotifier` for state management when needed
- Keep widget trees shallow for better performance

### Naming Conventions
- Use descriptive names for knobs
- Follow Flutter naming conventions
- Use consistent labeling across similar widgets
- Include units in labels when applicable

## Complete Examples

### Custom Button Widget
```dart
import 'dart:developer';
import 'package:ec_themes/ec_design.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent customButtonWidgetbook() {
  return WidgetbookComponent(
    name: 'Custom Button',
    useCases: [
      WidgetbookUseCase(
        name: 'Primary Button',
        builder: (context) {
          final textKnob = context.knobs.string(
            label: 'Button Text',
            initialValue: 'Click Me',
          );
          
          final colorKnob = context.knobs.color(
            label: 'Button Color',
            initialValue: Colors.blue,
          );
          
          final sizeKnob = context.knobs.object.dropdown(
            label: 'Button Size',
            options: ['Small', 'Medium', 'Large'],
          );

          return ECUiWidgetbook(
            copyCode: '''
            CustomButton(
              text: '$textKnob',
              color: $colorKnob,
              size: '$sizeKnob',
              onPressed: () {
                // Handle button press
              },
            ),
            ''',
            child: CustomButton(
              text: textKnob,
              color: colorKnob,
              size: sizeKnob,
              onPressed: () {
                log('Button pressed: $textKnob');
              },
            ),
          );
        },
      ),
      
      WidgetbookUseCase(
        name: 'Icon Button',
        builder: (context) {
          final iconKnob = context.knobs.object.dropdown(
            label: 'Icon',
            options: [
              Icon(EcDesignIcons.icArrowLeft),
              Icon(EcDesignIcons.icArrowRight),
              Icon(EcDesignIcons.icHome),
            ],
          );
          
          final disabledKnob = context.knobs.boolean(
            label: 'Disabled',
            initialValue: false,
          );

          return ECUiWidgetbook(
            copyCode: '''
            CustomButton.icon(
              icon: $iconKnob,
              disabled: $disabledKnob,
              onPressed: $disabledKnob ? null : () {
                // Handle button press
              },
            ),
            ''',
            child: CustomButton.icon(
              icon: iconKnob,
              disabled: disabledKnob,
              onPressed: disabledKnob ? null : () {
                log('Icon button pressed');
              },
            ),
          );
        },
      ),
    ],
  );
}
```

### Form Input Widget
```dart
WidgetbookComponent formInputWidgetbook() {
  return WidgetbookComponent(
    name: 'Form Input',
    useCases: [
      WidgetbookUseCase(
        name: 'Text Input',
        builder: (context) {
          final labelKnob = context.knobs.string(
            label: 'Label',
            initialValue: 'Email',
          );
          
          final placeholderKnob = context.knobs.string(
            label: 'Placeholder',
            initialValue: 'Enter your email',
          );
          
          final errorKnob = context.knobs.boolean(
            label: 'Show Error',
            initialValue: false,
          );

          return ECUiWidgetbook(
            copyCode: '''
            FormInput(
              label: '$labelKnob',
              placeholder: '$placeholderKnob',
              error: $errorKnob ? 'Invalid input' : null,
              onChanged: (value) {
                // Handle input change
              },
            ),
            ''',
            child: FormInput(
              label: labelKnob,
              placeholder: placeholderKnob,
              error: errorKnob ? 'Invalid input' : null,
              onChanged: (value) {
                log('Input changed: $value');
              },
            ),
          );
        },
      ),
    ],
  );
}
```

## Troubleshooting

### Common Issues

#### Widget Not Displaying
- Check import in `main.dart`
- Ensure widget is registered in `directories`
- Check console for errors
- Verify file path and naming

#### Knobs Not Working
- Ensure correct syntax for knobs
- Check `initialValue` matches the expected type
- Verify `builder` function is called correctly
- Check for null safety issues

#### Hot Reload Issues
- Use `flutter run` instead of `flutter build`
- Ensure files are saved
- Restart app if necessary
- Check for syntax errors

#### Performance Issues
- Reduce widget tree depth
- Use `const` constructors
- Avoid expensive operations in builders
- Implement proper state management

### Debug Tips
- Use `print` or `log` statements for debugging
- Check browser console for errors
- Verify all dependencies are properly imported
- Test knobs with simple values first

## Contributing

When adding new widgets to Widgetbook:

1. Follow the established naming conventions
2. Include comprehensive use cases
3. Provide clear code examples
4. Test all knobs and interactions
5. Update this documentation if needed

## Support

For issues or questions:
- Check the troubleshooting section above
- Review existing widget examples
- Consult Flutter and Widgetbook documentation
- Contact the development team

---
