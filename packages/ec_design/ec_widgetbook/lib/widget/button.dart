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
          final iconKnobs = context.knobs.object.dropdown(
            label: 'icon',
            options: [
              EcAssets.arrowLeft(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              EcAssets.arrowRight(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              EcAssets.bag(color: Theme.of(context).colorScheme.onPrimary),
              EcAssets.close(color: Theme.of(context).colorScheme.onPrimary),
              EcAssets.filter(color: Theme.of(context).colorScheme.onPrimary),
              EcAssets.heart(color: Theme.of(context).colorScheme.onPrimary),
              EcAssets.heartFilled(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              EcAssets.home(color: Theme.of(context).colorScheme.onPrimary),
            ],
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
                      icon: withIcon ? iconKnobs : null,
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
                      icon: iconKnobs,
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
                        icon: iconKnobs,
                        onPressed: () {},
                      ),
                      EcElevatedButton(text: 'Submit', onPressed: () {}),
                      EcElevatedButton(
                        text: 'Delete',
                        icon: iconKnobs,
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
          final iconKnobs = context.knobs.object.dropdown(
            label: 'icon',
            options: [
              EcAssets.arrowLeft(
                color: Theme.of(context).colorScheme.secondary,
              ),
              EcAssets.arrowRight(
                color: Theme.of(context).colorScheme.secondary,
              ),
              EcAssets.bag(color: Theme.of(context).colorScheme.secondary),
              EcAssets.close(color: Theme.of(context).colorScheme.secondary),
              EcAssets.filter(color: Theme.of(context).colorScheme.secondary),
              EcAssets.heart(color: Theme.of(context).colorScheme.secondary),
              EcAssets.heartFilled(
                color: Theme.of(context).colorScheme.secondary,
              ),
              EcAssets.home(color: Theme.of(context).colorScheme.secondary),
            ],
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
                      icon: withIcon ? iconKnobs : null,
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
                      icon: iconKnobs,
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
                        icon: iconKnobs,
                        onPressed: () {},
                      ),
                      EcOutlinedButton(
                        text: 'Share',
                        icon: iconKnobs,
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
          final iconKnobs = context.knobs.object.dropdown(
            label: 'icon',
            options: [
              EcAssets.arrowLeft(color: Theme.of(context).colorScheme.primary),
              EcAssets.arrowRight(color: Theme.of(context).colorScheme.primary),
              EcAssets.bag(color: Theme.of(context).colorScheme.primary),
              EcAssets.close(color: Theme.of(context).colorScheme.primary),
              EcAssets.filter(color: Theme.of(context).colorScheme.primary),
              EcAssets.heart(color: Theme.of(context).colorScheme.primary),
              EcAssets.heartFilled(
                color: Theme.of(context).colorScheme.primary,
              ),
              EcAssets.home(color: Theme.of(context).colorScheme.primary),
            ],
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
                      icon: withIcon ? iconKnobs : null,
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
                      icon: iconKnobs,
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
                        icon: iconKnobs,
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
        name: 'Icon Button',
        builder: (context) {
          // Create appropriate knobs for the current widget
          final iconKnobs = context.knobs.object.dropdown(
            label: 'icon',
            options: [
              EcAssets.arrowLeft(color: Colors.white),
              EcAssets.arrowRight(color: Colors.white),
              EcAssets.bag(color: Colors.white),
              EcAssets.close(color: Colors.white),
              EcAssets.filter(color: Colors.white),
              EcAssets.heart(color: Colors.white),
              EcAssets.heartFilled(color: Colors.white),
              EcAssets.home(color: Colors.white),
            ],
          );

          return ECUiWidgetbook(
            copyCode: '''
            EcIconButton(icon: EcAssets.arrowLeft(), onPressed: () {}),
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcTitleMediumText('Enable'),
                  SizedBox(height: 2),
                  EcIconButton(icon: iconKnobs, onPressed: () {}),

                  SizedBox(height: 20),

                  EcTitleMediumText('Disable'),
                  SizedBox(height: 2),
                  EcIconButton(icon: iconKnobs, enabled: false),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}
