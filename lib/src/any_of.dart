import 'regex_component.dart';

class AnyOf extends RegexComponent with RegexComponentPatterned {
  final List<RegexComponent> components;

  @override
  String get pattern => '(?:${components.patterns.join('|')})';

  const AnyOf(this.components);
}
