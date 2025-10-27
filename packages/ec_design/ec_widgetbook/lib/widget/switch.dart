import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_colors.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent switchWidgetBooks() {
  return WidgetbookComponent(
    name: 'Switch',
    useCases: [
      WidgetbookUseCase(
        name: 'Basic Switch',
        builder: (context) {
          return ECUiWidgetbook(
            copyCode: '''
EcSwitch(
  value: false,
  onChanged: (value) {},
  themeType: ECThemeType.user,
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Interactive switch:'),
                  const SizedBox(height: 16),
                  const _StatefulSwitch(),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text('Different states:'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Off'),
                          const SizedBox(height: 8),
                          const _StatefulSwitch(initialValue: false),
                        ],
                      ),
                      const SizedBox(width: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('On'),
                          const SizedBox(height: 8),
                          const _StatefulSwitch(initialValue: true),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Switch with Label',
        builder: (context) {
          final label = context.knobs.string(
            label: 'Label',
            initialValue: 'Enable notifications',
          );

          return ECUiWidgetbook(
            copyCode: '''
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('$label'),
    EcSwitch(
      value: false,
      onChanged: (value) {},
      themeType: ECThemeType.user,
    ),
  ],
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SwitchWithLabel(label: label),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text('Settings examples:'),
                  const SizedBox(height: 16),
                  const _SwitchWithLabel(
                    label: 'Dark mode',
                    initialValue: true,
                  ),
                  const SizedBox(height: 16),
                  const _SwitchWithLabel(
                    label: 'Auto-play videos',
                    initialValue: false,
                  ),
                  const SizedBox(height: 16),
                  const _SwitchWithLabel(
                    label: 'Show online status',
                    initialValue: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Switch Group',
        builder: (context) {
          final spacing = context.knobs.double.slider(
            label: 'Spacing',
            initialValue: 16,
            min: 0,
            max: 40,
          );

          return ECUiWidgetbook(
            copyCode: '''
Column(
  children: [
    _SwitchRow(
      label: 'Wi-Fi',
      value: true,
      onChanged: (value) {},
      themeType: ECThemeType.user,
    ),
    SizedBox(height: $spacing),
    _SwitchRow(
      label: 'Bluetooth',
      value: false,
      onChanged: (value) {},
      themeType: ECThemeType.user,
    ),
  ],
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Connectivity settings:'),
                  const SizedBox(height: 16),
                  _SwitchSettingsGroup(
                    spacing: spacing,
                    settings: const {
                      'Wi-Fi': true,
                      'Bluetooth': false,
                      'Airplane Mode': false,
                      'Mobile Data': true,
                    },
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text('Privacy settings:'),
                  const SizedBox(height: 16),
                  _SwitchSettingsGroup(
                    spacing: spacing,
                    settings: const {
                      'Location Services': true,
                      'Camera Access': true,
                      'Microphone Access': false,
                      'Contacts Access': true,
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Compact Layout',
        builder: (context) {
          return ECUiWidgetbook(
            copyCode: '''
Row(
  children: [
    EcSwitch(
      value: false,
      onChanged: (value) {},
      themeType: ECThemeType.user,
    ),
    SizedBox(width: 8),
    Text('Enable feature'),
  ],
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Compact switch with label:'),
                  const SizedBox(height: 16),
                  const _CompactSwitch(label: 'Quick toggle'),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text('Multiple compact switches:'),
                  const SizedBox(height: 16),
                  const _CompactSwitch(label: 'Option 1', initialValue: true),
                  const SizedBox(height: 12),
                  const _CompactSwitch(label: 'Option 2', initialValue: false),
                  const SizedBox(height: 12),
                  const _CompactSwitch(label: 'Option 3', initialValue: true),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}

// Stateful wrapper for interactive switch
class _StatefulSwitch extends StatefulWidget {
  final bool initialValue;

  const _StatefulSwitch({this.initialValue = false});

  @override
  State<_StatefulSwitch> createState() => _StatefulSwitchState();
}

class _StatefulSwitchState extends State<_StatefulSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(_StatefulSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EcSwitch(
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
      themeType: ECThemeType.user,
    );
  }
}

// Switch with label (right side)
class _SwitchWithLabel extends StatefulWidget {
  final String label;
  final bool initialValue;

  const _SwitchWithLabel({required this.label, this.initialValue = false});

  @override
  State<_SwitchWithLabel> createState() => _SwitchWithLabelState();
}

class _SwitchWithLabelState extends State<_SwitchWithLabel> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(_SwitchWithLabel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.label),
        EcSwitch(
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          themeType: ECThemeType.user,
        ),
      ],
    );
  }
}

// Switch settings group
class _SwitchSettingsGroup extends StatefulWidget {
  final double spacing;
  final Map<String, bool> settings;

  const _SwitchSettingsGroup({required this.spacing, required this.settings});

  @override
  State<_SwitchSettingsGroup> createState() => _SwitchSettingsGroupState();
}

class _SwitchSettingsGroupState extends State<_SwitchSettingsGroup> {
  late Map<String, bool> _settings;

  @override
  void initState() {
    super.initState();
    _settings = Map.from(widget.settings);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          _settings.entries.map((entry) {
            final isLast = entry.key == _settings.keys.last;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    EcSwitch(
                      value: entry.value,
                      onChanged: (value) {
                        setState(() {
                          _settings[entry.key] = value;
                        });
                      },
                      themeType: ECThemeType.user,
                    ),
                  ],
                ),
                if (!isLast) SizedBox(height: widget.spacing),
              ],
            );
          }).toList(),
    );
  }
}

// Compact switch with label on the right
class _CompactSwitch extends StatefulWidget {
  final String label;
  final bool initialValue;

  const _CompactSwitch({required this.label, this.initialValue = false});

  @override
  State<_CompactSwitch> createState() => _CompactSwitchState();
}

class _CompactSwitchState extends State<_CompactSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(_CompactSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        EcSwitch(
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          themeType: ECThemeType.user,
        ),
        const SizedBox(width: 12),
        Text(widget.label),
      ],
    );
  }
}
