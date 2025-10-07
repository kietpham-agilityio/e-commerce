import 'package:flutter/material.dart';
import '../../typography.dart';
import '../../app_colors.dart';
import '../../ec_theme_extension.dart';

/// Dropdown Item representing a selectable option in the dropdown
class EcDropdownItem<T> {
  EcDropdownItem({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
  });

  /// The actual value of the dropdown item
  final T value;

  /// The display label shown in the dropdown
  final String label;

  /// Optional subtitle for additional information
  final String? subtitle;

  /// Optional icon displayed before the label
  final IconData? icon;
}

/// State management for dropdown search functionality
class EcDropdownState<T> {
  EcDropdownState({
    required this.isExpanded,
    required this.filteredItems,
    required this.allItems,
    this.selectedItem,
    this.isLoading = false,
    this.errorMessage,
  });

  final bool isExpanded;
  final List<EcDropdownItem<T>> filteredItems;
  final List<EcDropdownItem<T>> allItems;
  final EcDropdownItem<T>? selectedItem;
  final bool isLoading;
  final String? errorMessage;

  EcDropdownState<T> copyWith({
    bool? isExpanded,
    List<EcDropdownItem<T>>? filteredItems,
    List<EcDropdownItem<T>>? allItems,
    EcDropdownItem<T>? selectedItem,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return EcDropdownState<T>(
      isExpanded: isExpanded ?? this.isExpanded,
      filteredItems: filteredItems ?? this.filteredItems,
      allItems: allItems ?? this.allItems,
      selectedItem: selectedItem ?? this.selectedItem,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Dropdown widget with search functionality
class EcDropdown<T> extends StatefulWidget {
  const EcDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.onSelected,
    this.onFetchItems,
    this.label,
    this.hintText,
    this.errorText,
    this.helperText,
    this.semanticsLabel,
    this.enabled = true,
    this.required = false,
    this.enableSearch = false,
    this.searchHintText = 'Search...',
    this.emptyMessage = 'No items found',
    this.errorRetryMessage = 'Failed to load items. Tap to retry.',
    this.maxHeight = 250,
    this.controller,
    this.focusNode,
    this.themeType = ECThemeType.user,
    this.isDark = false,
    this.prefixIcon,
    this.showIcon = true,
  });

  /// List of dropdown items
  final List<EcDropdownItem<T>> items;

  /// Currently selected value
  final T? selectedValue;

  /// Callback when text changes (for search)
  final ValueChanged<String>? onChanged;

  /// Callback when an item is selected
  final ValueChanged<T>? onSelected;

  /// Async function to fetch dropdown items
  final Future<List<EcDropdownItem<T>>> Function()? onFetchItems;

  /// Label text displayed above the dropdown
  final String? label;

  /// Hint text shown when no value is selected
  final String? hintText;

  /// Error text displayed when validation fails
  final String? errorText;

  /// Helper text displayed below the dropdown
  final String? helperText;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  /// Whether the dropdown is enabled
  final bool enabled;

  /// Whether the dropdown selection is required
  final bool required;

  /// Enable search/filter functionality
  final bool enableSearch;

  /// Hint text for search field
  final String searchHintText;

  /// Message shown when no items match search
  final String emptyMessage;

  /// Message shown when fetch fails
  final String errorRetryMessage;

  /// Maximum height of dropdown list
  final double maxHeight;

  /// Optional controller for managing dropdown text
  final TextEditingController? controller;

  /// Optional focus node for managing focus
  final FocusNode? focusNode;

  /// Theme type for styling
  final ECThemeType themeType;

  /// Whether dark mode is enabled
  final bool isDark;

  /// Optional prefix icon
  final Widget? prefixIcon;

  /// Whether to show dropdown arrow icon
  final bool showIcon;

  @override
  State<EcDropdown<T>> createState() => _EcDropdownState<T>();
}

class _EcDropdownState<T> extends State<EcDropdown<T>> {
  late EcDropdownState<T> _state;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final ScrollController _scrollController = ScrollController();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    // Initialize state
    _state = EcDropdownState<T>(
      isExpanded: false,
      filteredItems: widget.items,
      allItems: widget.items,
    );

    // Set initial selected item if provided
    if (widget.selectedValue != null) {
      final selectedItem = widget.items.firstWhere(
        (item) => item.value == widget.selectedValue,
        orElse: () => widget.items.first,
      );
      _controller.text = selectedItem.label;
      _state = _state.copyWith(selectedItem: selectedItem);
    }

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    _scrollController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _state.isExpanded) {
      if (mounted) {
        _toggleDropdown(false);
      }
    }
  }

  void _toggleDropdown([bool? expand]) async {
    if (!widget.enabled || !mounted) return;

    final shouldExpand = expand ?? !_state.isExpanded;

    if (shouldExpand) {
      _focusNode.requestFocus();

      // Fetch items if needed
      if (widget.onFetchItems != null && _state.allItems.isEmpty) {
        await _fetchItems();
      }

      if (!mounted) return;

      setState(() {
        _state = _state.copyWith(isExpanded: true);
      });
      _showOverlay();
    } else {
      _focusNode.unfocus();
      _removeOverlay();

      if (!mounted) return;

      setState(() {
        _state = _state.copyWith(isExpanded: false);
      });
    }
  }

  Future<void> _fetchItems() async {
    if (!mounted) return;

    setState(() {
      _state = _state.copyWith(isLoading: true, clearError: true);
    });

    try {
      final items = await widget.onFetchItems!();

      if (!mounted) return;

      setState(() {
        _state = _state.copyWith(
          filteredItems: items,
          allItems: items,
          isLoading: false,
        );
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _state = _state.copyWith(
          isLoading: false,
          errorMessage: widget.errorRetryMessage,
        );
      });
    }
  }

  void _filterItems(String query) {
    if (!widget.enableSearch || !mounted) return;

    final filtered =
        _state.allItems
            .where(
              (item) => item.label.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    setState(() {
      _state = _state.copyWith(filteredItems: filtered);
    });
    _updateOverlay();
  }

  void _selectItem(EcDropdownItem<T> item) {
    if (!mounted) return;

    _removeOverlay();
    _focusNode.unfocus();

    setState(() {
      _state = _state.copyWith(
        selectedItem: item,
        isExpanded: false,
        filteredItems: _state.allItems,
      );
      _controller.text = item.label;
    });

    widget.onSelected?.call(item.value);
  }

  void _showOverlay() {
    if (!mounted) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateOverlay() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry?.dispose();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    if (!mounted) {
      return OverlayEntry(builder: (_) => const SizedBox.shrink());
    }

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      return OverlayEntry(builder: (_) => const SizedBox.shrink());
    }

    final size = renderBox.size;

    return OverlayEntry(
      builder:
          (overlayContext) => GestureDetector(
            onTap: () {
              if (mounted && _state.isExpanded) {
                _toggleDropdown(false);
              }
            },
            behavior: HitTestBehavior.translucent,
            child: Stack(
              children: [
                // Invisible barrier to detect taps outside
                Positioned.fill(child: Container(color: Colors.transparent)),
                // Actual dropdown positioned at the correct location
                Positioned(
                  width: size.width,
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: Offset(0, size.height + 4),
                    child: GestureDetector(
                      onTap: () {}, // Prevent tap from propagating to parent
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(8),
                        child: _buildDropdownList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildDropdownList() {
    final ecTheme = Theme.of(context).extension<EcThemeExtension>()!;
    final colors = ecTheme.colors;

    if (_state.isLoading) {
      return Container(
        constraints: BoxConstraints(maxHeight: widget.maxHeight),
        padding: const EdgeInsets.all(16),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_state.errorMessage != null) {
      return GestureDetector(
        onTap: () {
          if (widget.onFetchItems != null) {
            _fetchItems();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: colors.error),
              const SizedBox(height: 8),
              Text(
                _state.errorMessage!,
                style: EcTypography.getBodyMedium(
                  ecTheme.themeType,
                  ecTheme.isDark,
                ).copyWith(color: colors.error),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (_state.filteredItems.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          widget.emptyMessage,
          style: EcTypography.getBodyMedium(
            ecTheme.themeType,
            ecTheme.isDark,
          ).copyWith(color: colors.outline),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _state.filteredItems.length,
        itemBuilder: (context, index) {
          final item = _state.filteredItems[index];
          final isSelected = _state.selectedItem?.value == item.value;

          return InkWell(
            onTap: () => _selectItem(item),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color:
                  isSelected
                      ? colors.primaryContainer.withValues(alpha: 0.3)
                      : null,
              child: Row(
                children: [
                  if (item.icon != null) ...[
                    Icon(item.icon, size: 20, color: colors.onSurface),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: EcTypography.getBodyMedium(
                            ecTheme.themeType,
                            ecTheme.isDark,
                          ).copyWith(
                            color:
                                isSelected ? colors.primary : colors.onSurface,
                            fontWeight:
                                isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                          ),
                        ),
                        if (item.subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            item.subtitle!,
                            style: EcTypography.getBodySmall(
                              ecTheme.themeType,
                              ecTheme.isDark,
                            ).copyWith(color: colors.outline),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check, size: 20, color: colors.primary),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context).extension<EcThemeExtension>()!;
    final colors = ecTheme.colors;

    return Semantics(
      label: widget.semanticsLabel ?? widget.label,
      hint: 'Dropdown field',
      toggled: _state.isExpanded,
      button: true,
      focusable: true,
      focused: _focusNode.hasFocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Row(
              children: [
                Text(
                  widget.label!,
                  style: EcTypography.getLabelLarge(
                    ecTheme.themeType,
                    ecTheme.isDark,
                  ),
                ),
                if (widget.required)
                  Text(
                    ' *',
                    style: EcTypography.getLabelLarge(
                      ecTheme.themeType,
                      ecTheme.isDark,
                    ).copyWith(color: colors.error),
                  ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          CompositedTransformTarget(
            link: _layerLink,
            child: TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              readOnly: !widget.enableSearch,
              onChanged: (value) {
                _filterItems(value);
                widget.onChanged?.call(value);
              },
              onTap: () => _toggleDropdown(true),
              style: EcTypography.getLabelMedium(
                ecTheme.themeType,
                ecTheme.isDark,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                errorText: widget.errorText,
                helperText: widget.helperText,
                prefixIcon: widget.prefixIcon,
                suffixIcon:
                    widget.showIcon
                        ? GestureDetector(
                          onTap: () => _toggleDropdown(),
                          child: Icon(
                            _state.isExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: colors.onSurface,
                          ),
                        )
                        : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 22,
                ),
                hintStyle: EcTypography.getLabelMedium(
                  ecTheme.themeType,
                  ecTheme.isDark,
                ).copyWith(color: colors.outline),
                helperStyle: EcTypography.getBodySmall(
                  ecTheme.themeType,
                  ecTheme.isDark,
                ),
                errorStyle: EcTypography.getBodySmall(
                  ecTheme.themeType,
                  ecTheme.isDark,
                ).copyWith(color: colors.error),
                filled: true,
                fillColor: colors.primaryContainer,
                border: _buildBorder(),
                enabledBorder: _buildBorder(),
                focusedBorder: _buildBorder(color: colors.primary),
                errorBorder: _buildBorder(color: colors.error),
                disabledBorder: _buildBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: color != null ? BorderSide(color: color) : BorderSide.none,
    );
  }
}
