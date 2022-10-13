import '../literal.dart';
import '../regex_component.dart';

abstract class Quantifier extends RegexComponent {
  String get quantifier;

  final RegexComponent component;
  final bool greedy;

  @override
  String get pattern {
    String componentPattern = component.pattern;
    if (component is Literal) {
      if ((component as Literal).literal.length > 1) {
        componentPattern = '(?:$componentPattern)';
      }
    }
    return '$componentPattern$quantifier${greedy ? '' : '?'}';
  }

  const Quantifier(
    this.component, {
    this.greedy = true,
  });
}
