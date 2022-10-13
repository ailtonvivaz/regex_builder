import 'regex_component.dart';

class ChoiceOf extends RegexComponent {
  final List<RegexComponent> components;

  const ChoiceOf(this.components);

  @override
  String get pattern => '(?:${components.map((e) => e.pattern).join('|')})';
}
