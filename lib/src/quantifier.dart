import 'capture.dart';
import 'character_class.dart';
import 'regex_component.dart';

abstract class Quantifier extends ParentRegexComponent {
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

class ZeroOrMore extends Quantifier {
  @override
  String get quantifier => '*';

  const ZeroOrMore(super.component, {super.greedy});
}

class OneOrMore extends Quantifier {
  @override
  String get quantifier => '+';

  const OneOrMore(super.component, {super.greedy});
}

class Optionally extends Quantifier {
  @override
  String get quantifier => '?';

  const Optionally(super.component, {super.greedy});
}
