import 'package:ec_themes/ec_design.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent buttonWidgetBooks() {
  return WidgetbookComponent(
    name: 'Button',
    useCases: [
      WidgetbookUseCase(
        name: 'Elevated Button',
        builder: (context) {
          final text = context.knobs.string(
            label: 'Button Text',
            initialValue: 'Elevated Button',
          );
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );
          final withIcon = context.knobs.boolean(
            label: 'With Icon',
            initialValue: false,
          );

          return ECUiWidgetbook(
            backgroundColor: Theme.of(context).colorScheme.surfaceDim,
            copyCode: '''
EcElevatedButton(
  text: '$text',
  ${withIcon ? 'icon: Icon(Icons.add, size: 20),' : ''}
  onPressed: () {
    // Handle button press
  },
)
            ''',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: EcElevatedButton(
                      text: text,
                      icon:
                          withIcon
                              ? Icon(
                                Icons.add,
                                size: 20,
                                color: Theme.of(context).colorScheme.onPrimary,
                              )
                              : null,
                      onPressed: enabled ? () {} : null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Default Button',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: EcElevatedButton(
                      text: 'Add to Cart',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'With Icon',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: EcElevatedButton(
                      text: 'Add to Cart',
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Disabled',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: EcElevatedButton(
                      text: 'Disabled Button',
                      onPressed: null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Various Actions',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      EcElevatedButton(
                        text: 'Save',
                        icon: Icon(
                          Icons.save,
                          size: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () {},
                      ),
                      EcElevatedButton(text: 'Submit', onPressed: () {}),
                      EcElevatedButton(
                        text: 'Delete',
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () {},
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
        name: 'Outlined Button',
        builder: (context) {
          final text = context.knobs.string(
            label: 'Button Text',
            initialValue: 'Outlined Button',
          );
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );
          final withIcon = context.knobs.boolean(
            label: 'With Icon',
            initialValue: false,
          );

          return ECUiWidgetbook(
            backgroundColor: Theme.of(context).colorScheme.surfaceDim,
            copyCode: '''
EcOutlinedButton(
  text: '$text',
  ${withIcon ? 'icon: Icon(Icons.add, size: 20),' : ''}
  onPressed: () {
    // Handle button press
  },
)
            ''',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: EcOutlinedButton(
                      text: text,
                      icon:
                          withIcon
                              ? Icon(
                                Icons.add,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              )
                              : null,
                      onPressed: enabled ? () {} : null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Default Button',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: EcOutlinedButton(
                      text: 'View Details',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'With Icon',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: EcOutlinedButton(
                      text: 'Add to Wishlist',
                      icon: Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Disabled',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: EcOutlinedButton(
                      text: 'Disabled Button',
                      onPressed: null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Various Actions',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      EcOutlinedButton(text: 'Cancel', onPressed: () {}),
                      EcOutlinedButton(
                        text: 'Filter',
                        icon: Icon(
                          Icons.filter_list,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {},
                      ),
                      EcOutlinedButton(
                        text: 'Share',
                        icon: Icon(
                          Icons.share,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {},
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
        name: 'Text Button',
        builder: (context) {
          final text = context.knobs.string(
            label: 'Button Text',
            initialValue: 'Text Button',
          );
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );
          final withIcon = context.knobs.boolean(
            label: 'With Icon',
            initialValue: false,
          );

          return ECUiWidgetbook(
            backgroundColor: Theme.of(context).colorScheme.surfaceDim,
            copyCode: '''
EcTextButton(
  text: '$text',
  ${withIcon ? 'icon: Icon(Icons.add, size: 20),' : ''}
  onPressed: () {
    // Handle button press
  },
)
            ''',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: EcTextButton(
                      text: text,
                      icon:
                          withIcon
                              ? Icon(
                                Icons.add,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              )
                              : null,
                      onPressed: enabled ? () {} : null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Default Button',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: EcTextButton(text: 'Learn More', onPressed: () {}),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'With Icon',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: EcTextButton(
                      text: 'See All',
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Disabled',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: EcTextButton(
                      text: 'Disabled Button',
                      onPressed: null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Various Actions',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      EcTextButton(text: 'Skip', onPressed: () {}),
                      EcTextButton(text: 'Forgot Password?', onPressed: () {}),
                      EcTextButton(
                        text: 'Edit',
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {},
                      ),
                    ],
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
