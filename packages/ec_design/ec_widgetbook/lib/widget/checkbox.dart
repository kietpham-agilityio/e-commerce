import 'package:ec_themes/ec_design.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent checkboxWidgetBooks() {
  return WidgetbookComponent(
    name: 'Checkbox',
    useCases: [
      WidgetbookUseCase(
        name: 'Basic Checkbox',
        builder: (context) {
          final text = context.knobs.string(
            label: 'Text',
            initialValue: 'I agree to the terms and conditions',
          );
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );

          return ECUiWidgetbook(
            copyCode: '''
EcCheckbox(
  value: true,
  onChanged: (value) {},
  text: '$text',
  enabled: $enabled,
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatefulCheckbox(text: text, enabled: enabled),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text('Different States:'),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Checked checkbox',
                    initialValue: true,
                  ),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Unchecked checkbox',
                    initialValue: false,
                  ),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Disabled checkbox',
                    enabled: false,
                    initialValue: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Tristate Checkbox',
        builder: (context) {
          final text = context.knobs.string(
            label: 'Text',
            initialValue: 'Select All',
          );

          return ECUiWidgetbook(
            copyCode: '''
EcCheckbox(
  value: null,
  onChanged: (value) {},
  text: '$text',
  tristate: true,
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tristate checkbox can have three states:'),
                  const SizedBox(height: 16),
                  _TristateCheckbox(text: text),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text('All three states:'),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Checked (true)',
                    initialValue: true,
                    tristate: true,
                  ),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Unchecked (false)',
                    initialValue: false,
                    tristate: true,
                  ),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Indeterminate (null)',
                    initialValue: null,
                    tristate: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Checkbox Group',
        builder: (context) {
          final spacing = context.knobs.double.slider(
            label: 'Spacing',
            initialValue: 28,
            min: 0,
            max: 50,
          );

          return ECUiWidgetbook(
            copyCode: '''
EcCheckboxColumn(
  spacing: $spacing,
  items: [
    EcCheckboxItem(
      value: false,
      onChanged: (value) {},
      text: 'Shoes',
    ),
    EcCheckboxItem(
      value: true,
      onChanged: (value) {},
      text: 'Bags',
    ),
    EcCheckboxItem(
      value: false,
      onChanged: (value) {},
      text: 'Accessories',
    ),
  ],
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filter by category:'),
                  const SizedBox(height: 16),
                  _CheckboxGroup(spacing: spacing),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text('Size filter:'),
                  const SizedBox(height: 16),
                  _SizeCheckboxGroup(spacing: spacing),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Text First Layout',
        builder: (context) {
          final text = context.knobs.string(
            label: 'Text',
            initialValue: 'Remember me',
          );

          return ECUiWidgetbook(
            copyCode: '''
EcCheckbox(
  value: false,
  onChanged: (value) {},
  text: '$text',
  checkboxFirst: false,
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Checkbox on the right side:'),
                  const SizedBox(height: 16),
                  _StatefulCheckbox(text: text, checkboxFirst: false),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text('Multiple examples:'),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Save preferences',
                    checkboxFirst: false,
                    initialValue: true,
                  ),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Enable notifications',
                    checkboxFirst: false,
                    initialValue: false,
                  ),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Subscribe to newsletter',
                    checkboxFirst: false,
                    initialValue: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Custom Styled',
        builder: (context) {
          final text = context.knobs.string(
            label: 'Text',
            initialValue: 'Custom checkbox',
          );
          final spacing = context.knobs.double.slider(
            label: 'Spacing',
            initialValue: 13,
            min: 0,
            max: 30,
          );
          final size = context.knobs.double.slider(
            label: 'Size',
            initialValue: 24,
            min: 16,
            max: 40,
          );

          return ECUiWidgetbook(
            copyCode: '''
EcCheckbox(
  value: false,
  onChanged: (value) {},
  text: '$text',
  spacing: $spacing,
  size: $size,
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatefulCheckbox(text: text, spacing: spacing, size: size),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text('Different sizes:'),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Small checkbox',
                    size: 18,
                    spacing: 8,
                  ),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Medium checkbox',
                    size: 24,
                    spacing: 13,
                  ),
                  const SizedBox(height: 16),
                  const _StatefulCheckbox(
                    text: 'Large checkbox',
                    size: 32,
                    spacing: 16,
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

// Stateful wrapper for interactive checkbox
class _StatefulCheckbox extends StatefulWidget {
  final String text;
  final bool enabled;
  final bool? initialValue;
  final bool tristate;
  final bool checkboxFirst;
  final double? spacing;
  final double? size;

  const _StatefulCheckbox({
    required this.text,
    this.enabled = true,
    this.initialValue = false,
    this.tristate = false,
    this.checkboxFirst = true,
    this.spacing,
    this.size,
  });

  @override
  State<_StatefulCheckbox> createState() => _StatefulCheckboxState();
}

class _StatefulCheckboxState extends State<_StatefulCheckbox> {
  late bool? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(_StatefulCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EcCheckbox(
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
      text: widget.text,
      enabled: widget.enabled,
      tristate: widget.tristate,
      checkboxFirst: widget.checkboxFirst,
      spacing: widget.spacing,
      size: widget.size,
    );
  }
}

// Tristate checkbox with cycling behavior
class _TristateCheckbox extends StatefulWidget {
  final String text;

  const _TristateCheckbox({required this.text});

  @override
  State<_TristateCheckbox> createState() => _TristateCheckboxState();
}

class _TristateCheckboxState extends State<_TristateCheckbox> {
  bool? _value;

  @override
  Widget build(BuildContext context) {
    return EcCheckbox(
      value: _value,
      onChanged: (value) {
        setState(() {
          // Cycle through: null -> false -> true -> null
          if (_value == null) {
            _value = false;
          } else if (_value == false) {
            _value = true;
          } else {
            _value = null;
          }
        });
      },
      text:
          '${widget.text} (${_value == null
              ? 'indeterminate'
              : _value!
              ? 'checked'
              : 'unchecked'})',
      tristate: true,
    );
  }
}

// Checkbox group for categories
class _CheckboxGroup extends StatefulWidget {
  final double spacing;

  const _CheckboxGroup({required this.spacing});

  @override
  State<_CheckboxGroup> createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<_CheckboxGroup> {
  final Map<String, bool> _selections = {
    'Shoes': false,
    'Bags': true,
    'Accessories': false,
    'Clothing': true,
  };

  @override
  Widget build(BuildContext context) {
    return EcCheckboxColumn(
      spacing: widget.spacing,
      items:
          _selections.entries
              .map(
                (entry) => EcCheckboxItem(
                  value: entry.value,
                  onChanged: (value) {
                    setState(() {
                      _selections[entry.key] = value ?? false;
                    });
                  },
                  text: entry.key,
                ),
              )
              .toList(),
    );
  }
}

// Checkbox group for sizes
class _SizeCheckboxGroup extends StatefulWidget {
  final double spacing;

  const _SizeCheckboxGroup({required this.spacing});

  @override
  State<_SizeCheckboxGroup> createState() => _SizeCheckboxGroupState();
}

class _SizeCheckboxGroupState extends State<_SizeCheckboxGroup> {
  final Map<String, bool> _sizes = {
    'XS': false,
    'S': true,
    'M': true,
    'L': false,
    'XL': false,
  };

  @override
  Widget build(BuildContext context) {
    return EcCheckboxColumn(
      spacing: widget.spacing,
      items:
          _sizes.entries
              .map(
                (entry) => EcCheckboxItem(
                  value: entry.value,
                  onChanged: (value) {
                    setState(() {
                      _sizes[entry.key] = value ?? false;
                    });
                  },
                  text: entry.key,
                ),
              )
              .toList(),
    );
  }
}
