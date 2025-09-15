## Custom Lint Setup

This step-by-step guide explains how to set up, run, debug, and create custom lint rules for this monorepo.

### 1. Overview
- Plugin package: `packages/ec_lint`
- Consumer app: `e_commerce_app`
- Current rules: See `packages/ec_lint/lib/ec_lint.dart` for active rules

### 2. Verify your environment
- Ensure Flutter/Dart is installed and available on PATH.
- Check your Dart version (target: >= 3.7.2 as per repo):
  ```bash
  dart --version
  ```
- Navigate to the repo root:
  ```bash
  cd ../e_commerce
  ```

### 3. Install dependencies
From the app directory:
```bash
cd e_commerce_app
flutter pub get
```
You should see dependencies resolving without errors.

### 4. Ensure the plugin is referenced by the app
Open `e_commerce_app/pubspec.yaml` and confirm dev dependencies include:
```yaml
dev_dependencies:
  custom_lint: ^0.8.0
  ec_lint:
    path: ../packages/ec_lint
```
If you changed anything, run `flutter pub get` again.

### 5. Enable the analyzer plugin
Open `e_commerce_app/analysis_options.yaml` and ensure:
```yaml
analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - min_variable_name_length
    # Add your rules here
```
If you just added/edited this file, restart your IDE's Dart Analysis (or reload the window).

### 6. Sanity check: run the linter once
```bash
cd e_commerce_app
dart run custom_lint
```
Expected outcomes:
- If there are no violations, you'll see "No issues found!".
- If there are violations, they will be listed with file/line and rule name.

### 7. Continuous linting (watch mode)
Use watch mode to hot-reload the plugin and re-run lint automatically on changes:
```bash
dart run custom_lint --watch
```
Keep this running while you work for immediate feedback.

### 8. Create a new custom rule
1. Create a rule under `packages/ec_lint/lib/src/`, e.g. `my_rule.dart`:
```dart
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class MyRule extends DartLintRule {
  MyRule() : super(code: const LintCode(
    name: 'my_rule',
    problemMessage: 'Brief description of the lint.',
  ));

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Example: flag every variable declaration
    context.registry.addVariableDeclaration((VariableDeclaration node) {
      reporter.atNode(node, code);
    });
  }
}
```
2. Register the rule in `packages/ec_lint/lib/ec_lint.dart`:
```dart
import 'src/my_rule.dart';

class _EcLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        MinVariableNameLengthRule(),
        MyRule(),
      ];
}
```
3. Enable it in `e_commerce_app/analysis_options.yaml`:
```yaml
custom_lint:
  rules:
    - min_variable_name_length
    - my_rule
```
4. Run:
```bash
cd e_commerce_app
dart run custom_lint --watch
```

### 9. Integrate with CI
Minimal example for a pipeline step (adapt to your CI):
```bash
flutter pub get
dart run custom_lint
```
To fail the pipeline on lints, parse the output and fail when non-empty.

---
