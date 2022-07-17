import '../group.dart';
import '../regex.dart';
import '../regex_modifier.dart';

abstract class Quantifier extends RegexModifier {
  String get quantifier;

  final bool greedy;

  @override
  Regex get regex {
    final componentPattern = component.pattern;
    final suffix = '$quantifier${greedy ? '' : '?'}';

    if (component.isUnitary) {
      return Regex('$componentPattern$suffix');
    } else {
      return Regex.builder(components: [
        Group(components: [component]),
        Regex(suffix),
      ]);
      // return '(?:$componentPattern)$suffix';
    }
  }

  const Quantifier(
    super.component, {
    this.greedy = true,
  });
}
