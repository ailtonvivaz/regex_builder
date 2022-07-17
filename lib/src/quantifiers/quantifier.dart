import '../capture.dart';
import '../character_class.dart';
import '../regex_component.dart';
import '../parent_regex_component.dart';

abstract class Quantifier extends ParentRegexComponent
    with RegexComponentPatterned {
  String get quantifier;

  final bool greedy;

  @override
  String get pattern {
    final componentPattern = component.pattern;
    final suffix = '$quantifier${greedy ? '' : '?'}';
    if (componentPattern.length == 1 ||
        component is CharacterClass ||
        component is Capture) {
      return '$componentPattern$suffix';
    } else {
      return '(?:$componentPattern)$suffix';
    }
  }

  const Quantifier(
    super.component, {
    this.greedy = true,
  });
}
