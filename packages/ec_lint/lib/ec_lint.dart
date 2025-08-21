library ec_lint;

import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'src/min_variable_name_length_rule.dart';

PluginBase createPlugin() => _EcLintPlugin();

class _EcLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return <LintRule>[MinVariableNameLengthRule()];
  }
}
