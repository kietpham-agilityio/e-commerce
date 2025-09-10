import 'package:flutter/material.dart';

import '../core/mock_scenario.dart';

class MockScenarioDialog<T> extends StatelessWidget {
  const MockScenarioDialog({
    super.key,
    required this.title,
    required this.scenarios,
    this.initialSelectedIndex,
  });

  final String title;
  final List<MockScenario<T>> scenarios;
  final int? initialSelectedIndex;

  @override
  Widget build(BuildContext context) {
    final bool hasItems = scenarios.isNotEmpty;
    return Dialog.fullscreen(
      child: SafeArea(
        child: _MockScenarioDialogContent<T>(
          title: title,
          scenarios: scenarios,
          hasItems: hasItems,
          initialSelectedIndex: initialSelectedIndex,
        ),
      ),
    );
  }
}

class _MockScenarioDialogContent<T> extends StatefulWidget {
  const _MockScenarioDialogContent({
    required this.title,
    required this.scenarios,
    required this.hasItems,
    this.initialSelectedIndex,
  });

  final String title;
  final List<MockScenario<T>> scenarios;
  final bool hasItems;
  final int? initialSelectedIndex;

  @override
  State<_MockScenarioDialogContent<T>> createState() =>
      _MockScenarioDialogContentState<T>();
}

class _MockScenarioDialogContentState<T>
    extends State<_MockScenarioDialogContent<T>> {
  late final ValueNotifier<int> selectedIndexNotifier;

  @override
  void initState() {
    super.initState();
    selectedIndexNotifier = ValueNotifier<int>(
      (widget.initialSelectedIndex != null &&
              widget.initialSelectedIndex! >= 0 &&
              widget.initialSelectedIndex! < widget.scenarios.length)
          ? widget.initialSelectedIndex!
          : 0,
    );
  }

  @override
  void dispose() {
    selectedIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ValueListenableBuilder<int>(
          valueListenable: selectedIndexNotifier,
          builder: (context, selectedIndex, _) {
            return _DialogHeader(
              title: widget.title,
              onApply:
                  widget.hasItems
                      ? () => Navigator.of(
                        context,
                      ).pop(widget.scenarios[selectedIndex])
                      : null,
            );
          },
        ),
        const Divider(height: 1),
        Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: selectedIndexNotifier,
            builder: (context, selectedIndex, _) {
              return _ScenarioList<T>(
                scenarios: widget.scenarios,
                selectedIndex: selectedIndex,
                onSelectIndex: (i) => selectedIndexNotifier.value = i,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.title, this.onApply});

  final String title;
  final VoidCallback? onApply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Close',
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          if (onApply != null)
            FilledButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text('Apply'),
              onPressed: onApply,
            ),
        ],
      ),
    );
  }
}

class _ScenarioList<T> extends StatelessWidget {
  const _ScenarioList({
    required this.scenarios,
    required this.selectedIndex,
    required this.onSelectIndex,
  });

  final List<MockScenario<T>> scenarios;
  final int selectedIndex;
  final ValueChanged<int> onSelectIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ListView.separated(
        itemCount: scenarios.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = scenarios[index];
          final bool isSelected = index == selectedIndex;
          return ListTile(
            selected: isSelected,
            title: Text(item.name),
            subtitle: item.description == null ? null : Text(item.description!),
            onTap: () => onSelectIndex(index),
          );
        },
      ),
    );
  }
}
