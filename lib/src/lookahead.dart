import 'regex_component.dart';

class LookAhead extends RegexComponent {
  final List<RegexComponent> components;

  LookAhead(this.components);

  @override
  String get pattern => '?=${components.map((c) => c.pattern).join()}';

  @override
  bool match(String input) => true; 
}

