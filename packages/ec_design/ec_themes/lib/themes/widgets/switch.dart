import 'package:ec_themes/themes/app_colors.dart';
import 'package:ec_themes/themes/app_sizing.dart';
import 'package:flutter/material.dart';

/// {@template ec_switch}
/// A custom animated switch widget for EC themes, following Material 3 design.
///
/// The [EcSwitch] widget provides a toggle switch with smooth animation and
/// theme-aware colors. It is designed to be consistent with the EC design system,
/// using [AppSizing] and [AppColors] for sizing and color theming.
///
/// The switch animates between on and off states, and notifies changes via [onChanged].
///
/// See also:
///  * [Switch], the Material Design switch.
/// {@endtemplate}
class EcSwitch extends StatefulWidget {
  /// Creates an [EcSwitch].
  ///
  /// The [value] and [onChanged] arguments must not be null.
  const EcSwitch({
    required this.value,
    required this.onChanged,
    required this.themeType,
    super.key,
  });

  /// Whether this switch is on or off.
  final bool value;

  /// Called when the user toggles the switch.
  final ValueChanged<bool> onChanged;

  final ECThemeType themeType;

  @override
  State<EcSwitch> createState() => _EcSwitchState();
}

/// State for [EcSwitch].
class _EcSwitchState extends State<EcSwitch>
    with SingleTickerProviderStateMixin {
  /// Controls the animation for the switch thumb.
  late AnimationController _controller;

  /// Animation for the thumb's position.
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.value ? 1.0 : 0.0,
    );

    _animation = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(EcSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Animate to the new value when the widget updates.
    if (widget.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Toggle the switch when tapped.
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 33,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.1),
            ),
            child: Align(
              alignment:
                  Alignment.lerp(
                    Alignment.centerLeft,
                    Alignment.centerRight,
                    _animation.value,
                  )!,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      widget.value
                          ? Theme.of(context).colorScheme.tertiaryContainer
                          : Theme.of(context).colorScheme.onSecondary,
                  boxShadow: [
                    BoxShadow(
                      color:
                          widget.value
                              ? Theme.of(context).colorScheme.tertiaryContainer
                              : Colors.transparent,
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
