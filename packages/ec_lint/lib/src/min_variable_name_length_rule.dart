import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class MinVariableNameLengthRule extends DartLintRule {
  MinVariableNameLengthRule() : super(code: _code);

  static const int _minLength = 3;
  static const Set<String> _allowedShortNames = {'i', 'j', 'k'};

  static const LintCode _code = LintCode(
    name: 'min_variable_name_length',
    problemMessage: 'Variable name should be at least $_minLength characters.',
    correctionMessage: 'Rename the variable to have ≥ $_minLength characters.',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Local variables, fields, and top-level variables
    context.registry.addVariableDeclaration((VariableDeclaration node) {
      final identifier = node.name.lexeme;
      final visibleName = identifier.replaceFirst(RegExp('^_+'), '');
      if (_allowedShortNames.contains(visibleName)) return;
      if (visibleName.length < _minLength) {
        reporter.atToken(node.name, code);
      }
    });

    // Formal parameters
    context.registry.addSimpleFormalParameter((SimpleFormalParameter node) {
      final token = node.name;
      if (token == null) return;
      final identifier = token.lexeme;
      final visibleName = identifier.replaceFirst(RegExp('^_+'), '');
      if (_allowedShortNames.contains(visibleName)) return;
      if (visibleName.length < _minLength) {
        reporter.atToken(token, code);
      }
    });
  }
}
