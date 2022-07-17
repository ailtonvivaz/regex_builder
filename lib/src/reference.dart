import 'regex_component.dart';

class Reference extends RegexComponent with RegexComponentPatterned {
  final String name;

  @override
  String get pattern => '\\k<$name>';

  const Reference(this.name);
}
