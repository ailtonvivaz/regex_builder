import 'regex_component.dart';

class LookAhead extends RegexComponent {
  LookAhead(this.components, {this.positive = true});

  final List<RegexComponent> components;
  final bool positive;

  String get pattern =>
      positive ? '(?=${_buildPattern(components)})' : '(?!${_buildPattern(components)})';

  String _buildPattern(List<RegexComponent> components) =>
      components.map((c) => c.pattern).join('');
}

