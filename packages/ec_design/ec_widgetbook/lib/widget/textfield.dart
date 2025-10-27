import 'package:ec_themes/ec_design.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent textfieldWidgetBooks() {
  return WidgetbookComponent(
    name: 'Textfield',
    useCases: [
      WidgetbookUseCase(
        name: 'Textfield/Ordinary',
        builder: (context) {
          final hintText = context.knobs.string(
            label: 'Hint Text',
            initialValue: 'Enter your email',
          );
          final labelText = context.knobs.stringOrNull(
            label: 'Label Text',
            initialValue: 'Email Address',
          );
          final helperText = context.knobs.stringOrNull(
            label: 'Helper Text',
            initialValue: 'We will never share your email',
          );
          final errorText = context.knobs.stringOrNull(label: 'Error Text');
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );
          final readOnly = context.knobs.boolean(
            label: 'Read Only',
            initialValue: false,
          );
          final required = context.knobs.boolean(
            label: 'Required',
            initialValue: false,
          );
          final obscureText = context.knobs.boolean(
            label: 'Obscure Text',
            initialValue: false,
          );

          return ECUiWidgetbook(
            backgroundColor: Theme.of(context).colorScheme.surfaceDim,
            copyCode: '''
EcOrdinaryTextField(
  hintText: '$hintText',
  labelText: ${labelText != null ? "'$labelText'" : 'null'},
  helperText: ${helperText != null ? "'$helperText'" : 'null'},
  errorText: ${errorText != null ? "'$errorText'" : 'null'},
  enabled: $enabled,
  readOnly: $readOnly,
  required: $required,
  obscureText: $obscureText,
  onChanged: (value) {
    // Handle text change
  },
)
            ''',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcOrdinaryTextField(
                    hintText: hintText,
                    labelText: labelText,
                    helperText: helperText,
                    errorText: errorText,
                    enabled: enabled,
                    readOnly: readOnly,
                    required: required,
                    obscureText: obscureText,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 24),
                  EcOrdinaryTextField(
                    hintText: 'Password field example',
                    labelText: 'Password',
                    obscureText: true,
                    required: true,
                  ),
                  const SizedBox(height: 24),
                  EcOrdinaryTextField(
                    hintText: 'Disabled field',
                    labelText: 'Disabled',
                    enabled: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Textfield/Small',
        builder: (context) {
          final hintText = context.knobs.string(
            label: 'Hint Text',
            initialValue: 'Enter text',
          );
          final labelText = context.knobs.stringOrNull(
            label: 'Label Text',
            initialValue: 'Quick Input',
          );
          final errorText = context.knobs.stringOrNull(label: 'Error Text');
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );
          final readOnly = context.knobs.boolean(
            label: 'Read Only',
            initialValue: false,
          );

          return ECUiWidgetbook(
            backgroundColor: Theme.of(context).colorScheme.surfaceDim,
            copyCode: '''
EcSmallTextField(
  hintText: '$hintText',
  labelText: ${labelText != null ? "'$labelText'" : 'null'},
  errorText: ${errorText != null ? "'$errorText'" : 'null'},
  enabled: $enabled,
  readOnly: $readOnly,
  onChanged: (value) {
    // Handle text change
  },
)
            ''',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcSmallTextField(
                    hintText: hintText,
                    labelText: labelText,
                    errorText: errorText,
                    enabled: enabled,
                    readOnly: readOnly,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 24),
                  EcSmallTextField(
                    hintText: 'With suffix icon',
                    labelText: 'Name',
                    suffixIcon: Icon(
                      Icons.clear,
                      size: 20,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    onTrailingIconTap: () {},
                  ),
                  const SizedBox(height: 24),
                  EcSmallTextField(
                    hintText: 'With prefix icon',
                    labelText: 'Category',
                    prefixIcon: Icon(
                      Icons.category,
                      size: 20,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  EcSmallTextField(
                    hintText: 'Error state',
                    labelText: 'Email',
                    errorText: 'Invalid email address',
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Search Bar',
        builder: (context) {
          final hintText = context.knobs.string(
            label: 'Hint Text',
            initialValue: 'What are you looking for?',
          );
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );
          final readOnly = context.knobs.boolean(
            label: 'Read Only',
            initialValue: false,
          );

          return ECUiWidgetbook(
            backgroundColor: Theme.of(context).colorScheme.surfaceDim,
            copyCode: '''
EcSearchTextField(
  hintText: '$hintText',
  enabled: $enabled,
  readOnly: $readOnly,
  onSearch: (value) {
    // Handle search query
  },
  onSearchSubmit: () {
    // Handle search submit
  },
)
            ''',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcSearchTextField(
                    hintText: hintText,
                    enabled: enabled,
                    readOnly: readOnly,
                    onSearch: (value) {},
                    onSearchSubmit: () {},
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Default search bar',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  EcSearchTextField(
                    hintText: 'Search products...',
                    onSearch: (value) {},
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'With label',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  EcSearchTextField(
                    hintText: 'Search',
                    labelText: 'Product Search',
                    onSearch: (value) {},
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Disabled state',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const EcSearchTextField(
                    hintText: 'Disabled search',
                    enabled: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Big Input/Review',
        builder: (context) {
          final hintText = context.knobs.string(
            label: 'Hint Text',
            initialValue: 'Write your review here...',
          );
          final labelText = context.knobs.stringOrNull(
            label: 'Label Text',
            initialValue: 'Review',
          );
          final helperText = context.knobs.stringOrNull(
            label: 'Helper Text',
            initialValue: 'Share your thoughts about this product',
          );
          final maxLength = context.knobs.int.slider(
            label: 'Max Length',
            initialValue: 500,
            min: 100,
            max: 1000,
          );
          final minLines = context.knobs.int.slider(
            label: 'Min Lines',
            initialValue: 5,
            min: 3,
            max: 10,
          );
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );

          return ECUiWidgetbook(
            backgroundColor: Theme.of(context).colorScheme.surfaceDim,
            copyCode: '''
EcBigInputTextField(
  hintText: '$hintText',
  labelText: ${labelText != null ? "'$labelText'" : 'null'},
  helperText: ${helperText != null ? "'$helperText'" : 'null'},
  maxLength: $maxLength,
  minLines: $minLines,
  enabled: $enabled,
  onChanged: (value) {
    // Handle text change
  },
)
            ''',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcBigInputTextField(
                    hintText: hintText,
                    labelText: labelText,
                    helperText: helperText,
                    maxLength: maxLength,
                    minLines: minLines,
                    enabled: enabled,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Comment field',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  EcBigInputTextField(
                    hintText: 'Add a comment...',
                    labelText: 'Comment',
                    maxLength: 300,
                    minLines: 3,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Feedback field',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  EcBigInputTextField(
                    hintText: 'Tell us how we can improve...',
                    labelText: 'Feedback',
                    helperText: 'Your feedback helps us improve',
                    maxLength: 1000,
                    minLines: 5,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}
