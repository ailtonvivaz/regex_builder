import 'regex_component.dart';

abstract class RegexModifier extends RegexComponent {
  final RegexComponent component;

  const RegexModifier(this.component);
}
