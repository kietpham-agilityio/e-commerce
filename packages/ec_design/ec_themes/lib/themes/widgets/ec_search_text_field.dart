import 'package:flutter/material.dart';
import '../typography.dart';
import '../app_colors.dart';

/// Search text field widget with search icon and functionality
class EcSearchTextField extends StatefulWidget {
  /// The semantic label for accessibility (screen readers)
  final String? semanticsLabel;

  /// Controller for the text field
  final TextEditingController? controller;

  /// Initial value for the text field
  final String? initialValue;

  /// Hint text displayed when field is empty
  final String? hintText;

  /// Label text displayed above the field
  final String? labelText;

  /// Helper text displayed below the field
  final String? helperText;

  /// Error text displayed when validation fails
  final String? errorText;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether the field is read-only
  final bool readOnly;

  /// Whether the field is required
  final bool required;

  /// Maximum number of lines for multiline fields
  final int? maxLines;

  /// Minimum number of lines for multiline fields
  final int? minLines;

  /// Maximum number of characters allowed
  final int? maxLength;

  /// Focus node for the field
  final FocusNode? focusNode;

  /// Callback when text changes
  final ValueChanged<String>? onSearch;

  /// Callback for search submit
  final VoidCallback? onSearchSubmit;

  /// Callback when field is submitted
  final ValueChanged<String>? onSubmitted;

  /// Callback when field gains focus
  final VoidCallback? onTap;

  /// Callback when field loses focus
  final VoidCallback? onFocusLost;

  /// Callback when user taps outside the text field
  final VoidCallback? onTapOutside;

  /// Whether the text field should autofocus when the widget is built
  final bool autofocus;

  /// Whether the text field should show validation feedback
  final bool hasValidation;

  /// Callback for validation
  final String? Function(String?)? validator;

  /// Prefix icon
  final Widget? prefixIcon;

  /// Theme type for styling
  final ECThemeType themeType;

  /// Whether dark mode is enabled
  final bool isDark;

  /// Custom decoration
  final InputDecoration? decoration;

  /// Border radius
  final double? borderRadius;

  /// Content padding
  final EdgeInsetsGeometry? contentPadding;

  const EcSearchTextField({
    super.key,
    this.semanticsLabel,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
    this.onSearch,
    this.onSearchSubmit,
    this.onSubmitted,
    this.onTap,
    this.onFocusLost,
    this.onTapOutside,
    this.autofocus = false,
    this.hasValidation = true,
    this.validator,
    this.prefixIcon,
    this.themeType = ECThemeType.user,
    this.isDark = false,
    this.decoration,
    this.borderRadius,
    this.contentPadding,
  });

  @override
  State<EcSearchTextField> createState() => _EcSearchTextFieldState();
}

class _EcSearchTextFieldState extends State<EcSearchTextField> {
  late final TextEditingController? _controller;
  late final FocusNode? _focusNode;
  bool _hasFocus = false;
  bool _hasBeenEdited = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.initialValue != null && widget.controller == null) {
      _controller!.text = widget.initialValue!;
    }

    _focusNode!.addListener(() {
      if (mounted) {
        setState(() {
          _hasFocus = _focusNode.hasFocus;
        });

        if (!_focusNode.hasFocus) {
          widget.onFocusLost?.call();
          widget.onTapOutside?.call();
        }
      }
    });

    _controller!.addListener(() {
      if (mounted) {
        setState(() {
          _hasBeenEdited = _controller.text.isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    super.dispose();
  }

  /// Determine if error message should be shown
  /// Hide error when field has focus or is being edited, or when hasValidation is false
  bool _shouldShowError() {
    return widget.hasValidation &&
        widget.errorText != null &&
        !_hasFocus &&
        _hasBeenEdited;
  }

  @override
  Widget build(BuildContext context) {
    final colors =
        widget.isDark
            ? EcColors.dark(widget.themeType)
            : EcColors.light(widget.themeType);

    return Semantics(
      label: widget.semanticsLabel,
      textField: true,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onChanged: widget.onSearch,
        onFieldSubmitted: (value) {
          widget.onSearchSubmit?.call();
          widget.onSubmitted?.call(value);
        },
        onTap: widget.onTap,
        validator: widget.validator,
        style: EcTypography.getLabelMedium(widget.themeType, widget.isDark),
        decoration:
            widget.decoration ??
            InputDecoration(
              hintText: widget.hintText ?? 'Search...',
              errorText: _shouldShowError() ? widget.errorText : null,
              prefixIcon:
                  widget.prefixIcon ??
                  Icon(Icons.search, color: colors.outline),
              suffixIcon:
                  (_controller?.text.isNotEmpty ?? false)
                      ? IconButton(
                        icon: Icon(Icons.clear, color: colors.outline),
                        onPressed: () {
                          _controller?.clear();
                          widget.onSearch?.call('');
                          setState(() {});
                        },
                      )
                      : null,
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintStyle: EcTypography.getLabelMedium(
                widget.themeType,
                widget.isDark,
              ).copyWith(color: colors.outline),
              filled: true,
              fillColor: colors.primaryContainer,
              border: _buildBorder(borderRadius: 8),
              enabledBorder: _buildBorder(borderRadius: 8),
              focusedBorder: _buildBorder(
                color: colors.primary,
                borderRadius: 8,
              ),
              errorBorder:
                  widget.errorText != null && _shouldShowError()
                      ? _buildBorder(color: colors.error, borderRadius: 8)
                      : _buildBorder(borderRadius: 8),
              focusedErrorBorder:
                  widget.errorText != null && _shouldShowError()
                      ? _buildBorder(color: colors.error, borderRadius: 8)
                      : _buildBorder(borderRadius: 8),
              disabledBorder: _buildBorder(borderRadius: 8),
            ),
      ),
    );
  }

  /// Build border for text field
  OutlineInputBorder _buildBorder({Color? color, double? borderRadius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        borderRadius ?? widget.borderRadius ?? 8,
      ),
      borderSide: color != null ? BorderSide(color: color) : BorderSide.none,
    );
  }
}
