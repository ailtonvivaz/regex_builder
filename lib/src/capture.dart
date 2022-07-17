import 'regex_component.dart';
import 'parent_regex_component.dart';

class Capture extends ParentRegexComponent with RegexComponentPatterned {
  final String? name;

  Capture(
    super.component, {
    this.name,
  });

  @override
  String get pattern {
    final pattern = component.pattern;
    if (name == null) {
      return '($pattern)';
    } else {
      return '(?<$name>$pattern)';
    }
  }
}
