import 'regex_component.dart';

abstract class ParentRegexComponent extends RegexComponent {
  final RegexComponent component;

  const ParentRegexComponent(this.component);
}
