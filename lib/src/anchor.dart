import 'regex_component.dart';

/// A regex component that matches a specific condition at a particular position
/// in an input string.
///
/// You can use anchors to guarantee that a match only occurs at certain points
/// in an input string, such as at the beginning of the string or at the end of
/// a line.
///
/// ## Sample
///
class Anchor extends RegexComponent {
  @override
  final String pattern;

  /// An anchor that matches at the start of a line, including the start of
  /// the input string.
  ///
  /// This anchor is equivalent to `^` in regex syntax when the `multiline`
  /// option has been enabled.
  static const Anchor startOfLine = Anchor(r'^');

  /// An anchor that matches at the end of a line, including the end of the
  /// input string.
  ///
  /// This anchor is equivalent to `$` in regex syntax when the `multiline`
  /// option has been enabled.
  static const Anchor endOfLine = Anchor(r'$');

  /// An anchor that matches at a word boundary.
  ///
  /// Word boundaries are identified using the Unicode default word boundary
  /// algorithm by default. To specify a different word boundary algorithm,
  /// see the `RegexComponent.wordBoundaryKind(_:)` method.
  ///
  /// This anchor is equivalent to `\b` in regex syntax.
  static const Anchor wordBoundary = Anchor(r'\b');

  /// Creates a new anchor.
  static const Anchor nonWordBoundary = Anchor(r'\B');

  const Anchor(this.pattern);
}
