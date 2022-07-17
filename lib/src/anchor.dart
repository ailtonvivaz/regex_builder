import 'regex_component.dart';

class Anchor extends RegexComponent {
  @override
  final String pattern;

  static const Anchor startOfLine = Anchor._(r'^');
  static const Anchor endOfLine = Anchor._(r'$');
  static const Anchor wordBoundary = Anchor._(r'\b');
  static const Anchor nonWordBoundary = Anchor._(r'\B');

  const Anchor._(this.pattern);
}
