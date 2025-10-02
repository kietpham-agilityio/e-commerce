import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class MinVariableNameLengthRule extends DartLintRule {
  MinVariableNameLengthRule() : super(code: _code);

  static const int _minLength = 3;
  static const Set<String> _allowedShortNames = {
    'i',
    'j',
    'k',
    'id',
    '_',
    '__',
    '___',
  };

  static const LintCode _code = LintCode(
    name: 'min_variable_name_length',
    problemMessage: 'Variable name should be at least $_minLength characters.',
    correctionMessage: 'Rename the variable to have ≥ $_minLength characters.',
  );

  /// Check whether a variable name is invalid
  /// - Null names are ignored
  /// - Whitelisted short names are allowed
  /// - Leading underscores are stripped before validation
  /// - Names shorter than [_minLength] are considered invalid
  bool _isInvalidName(String? name) {
    if (name == null) return false;

    // Skip if the name is in the allowed list
    if (_allowedShortNames.contains(name)) return false;

    // Remove leading underscores (e.g. `_foo` → `foo`)
    final visibleName = name.replaceFirst(RegExp('^_+'), '');

    // Skip if the stripped name is in the allowed list
    if (_allowedShortNames.contains(visibleName)) return false;

    // Mark as invalid if the visible name is too short
    return visibleName.length < _minLength;
  }

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Validate local variables, fields, and top-level variables
    context.registry.addVariableDeclaration((VariableDeclaration node) {
      if (_isInvalidName(node.name.lexeme)) {
        reporter.atToken(node.name, code);
      }
    });

    // Validate formal parameters (function/method parameters)
    context.registry.addSimpleFormalParameter((SimpleFormalParameter node) {
      final token = node.name;
      if (_isInvalidName(token?.lexeme)) {
        reporter.atToken(token!, code);
      }
    });
  }
}
