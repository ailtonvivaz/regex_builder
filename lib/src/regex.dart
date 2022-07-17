import 'regex_component.dart';

class Regex extends RegexComponent implements Pattern {
  @override
  final String pattern;

  final bool multiLine;
  final bool caseSensitive;
  final bool unicode;
  final bool dotAll;

  @override
  // ignore: invalid_override_of_non_virtual_member
  Regex get regex => this;

  const Regex(String pattern) : this._(pattern);

  factory Regex.builder({
    required RegexComponents components,
    bool multiLine = false,
    bool caseSensitive = true,
    bool unicode = false,
    bool dotAll = false,
  }) {
    return Regex._(
      components.pattern,
      multiLine: multiLine,
      caseSensitive: caseSensitive,
      unicode: unicode,
      dotAll: dotAll,
    );
  }

  const Regex.any() : this('.');

  factory Regex.literal(String literal) => Regex(RegExp.escape(literal));

  const Regex._(
    this.pattern, {
    this.multiLine = false,
    this.caseSensitive = true,
    this.unicode = false,
    this.dotAll = false,
  });

  @override
  Iterable<Match> allMatches(String string, [int start = 0]) {
    return toRegExp().allMatches(string, start);
  }

  @override
  Match? matchAsPrefix(String string, [int start = 0]) {
    return toRegExp().matchAsPrefix(string, start);
  }

  RegExp toRegExp() => RegExp(
        pattern,
        multiLine: multiLine,
        caseSensitive: caseSensitive,
        unicode: unicode,
        dotAll: dotAll,
      );
}
