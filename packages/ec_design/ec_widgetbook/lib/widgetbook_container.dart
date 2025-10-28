import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ECUiWidgetbook extends StatelessWidget {
  const ECUiWidgetbook({
    required this.child,
    required this.copyCode,
    this.backgroundColor,
    this.sizeHeight,
    this.sizeWith,
    this.boxShadow,
    super.key,
  });

  final Widget child;
  final String copyCode;
  final Color? backgroundColor;
  final double? sizeHeight;
  final double? sizeWith;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: ExpansionBody(code: copyCode),
        body: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}

class ExpansionBody extends StatefulWidget {
  const ExpansionBody({super.key, this.onCopy, required this.code});

  final Function(Widget)? onCopy;
  final String code;

  @override
  State<ExpansionBody> createState() => _ExpansionBodyState();
}

class _ExpansionBodyState extends State<ExpansionBody> {
  final ValueNotifier<bool> _customTileExpanded = ValueNotifier<bool>(false);
  final ExpansionTileController controller = ExpansionTileController();

  @override
  void dispose() {
    _customTileExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final copycode = Text(widget.code);
    return SingleChildScrollView(
      child: ExpansionTile(
        controller: controller,
        // iconColor: Theme.of(context).colorScheme.primary,
        collapsedIconColor: Theme.of(context).colorScheme.primary,
        onExpansionChanged: (bool expanded) {
          _customTileExpanded.value = expanded;
        },
        trailing: Wrap(
          spacing: 10,
          children: [
            IconButton(
              onPressed: () {
                if (controller.isExpanded) {
                  controller.collapse();
                } else {
                  controller.expand();
                }
              },
              icon: ValueListenableBuilder<bool>(
                valueListenable: _customTileExpanded,
                builder:
                    (context, isExpanded, _) => Icon(
                      isExpanded ? Icons.expand_more : Icons.expand_less,
                    ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await FlutterClipboard.copy(copycode.data ?? '').then((value) {
                  if (context.mounted) {
                    return ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Text Copied')),
                    );
                  }
                });
              },
              icon: const Icon(Icons.content_copy),
            ),
          ],
        ),
        title: Text(''),
        children: [ListTile(title: copycode)],
      ),
    );
  }
}
