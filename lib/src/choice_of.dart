import 'regex_component.dart';

/// Matches one of the [components].
class ChoiceOf extends RegexComponent {
  final List<RegexComponent> components;

  const ChoiceOf(this.components);

  @override
  String get pattern => '(?:${components.map((e) => e.pattern).join('|')})';
}
