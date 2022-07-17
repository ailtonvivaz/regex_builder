import 'regex_component.dart';

class AnyOf extends RegexComponent {
  final List<RegexComponent> components;

  @override
  String get pattern => '(?:${components.map((c) => c.pattern).join('|')})';

  const AnyOf(this.components);
}
