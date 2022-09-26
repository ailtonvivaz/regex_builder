import 'regex_component.dart';

class Regex extends RegexComponent implements RegExp {
  @override
  final String pattern;

  @override
  final bool isMultiLine;

  @override
  final bool isCaseSensitive;

  @override
  final bool isUnicode;

  @override
  final bool isDotAll;

  @override
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
    bool multiLine = false,
    bool caseSensitive = true,
    bool unicode = false,
    bool dotAll = false,
  })  : isMultiLine = multiLine,
        isCaseSensitive = caseSensitive,
        isUnicode = unicode,
        isDotAll = dotAll;

  RegExp _toRegExp() => RegExp(
        pattern,
        multiLine: isMultiLine,
        caseSensitive: isCaseSensitive,
        unicode: isUnicode,
        dotAll: isDotAll,
      );

  /// Finds the first match of the regular expression in the string [input].
  ///
  /// Returns `null` if there is no match.
  /// ```dart
  /// final string = '[00:13.37] This is a chat message.';
  /// final regex = Regex.builder(components: [
  ///   Regex.literal('c'),
  ///   ZeroOrMore(CharacterClass.word),
  /// ]); // c\w*
  /// final match = regex.firstMatch(string)!;
  /// print(match[0]); // chat
  /// ```
  @override
  RegExpMatch? firstMatch(String input) => _toRegExp().firstMatch(input);

  @override
  bool hasMatch(String input) => _toRegExp().hasMatch(input);

  @override
  String? stringMatch(String input) => _toRegExp().stringMatch(input);

  /// Matches this pattern against the string repeatedly.
  ///
  /// If [start] is provided, matching will start at that index.
  ///
  /// The returned iterable lazily finds non-overlapping matches
  /// of the pattern in the [string].
  /// If a user only requests the first match,
  /// this function should not compute all possible matches.
  ///
  /// The matches are found by repeatedly finding the first match
  /// of the pattern in the string, initially starting from [start],
  /// and then from the end of the previous match (but always
  /// at least one position later than the *start* of the previous
  /// match, in case the pattern matches an empty substring).
  /// ```dart
  /// final regex = Regex.builder(components: [
  ///   Group(
  ///     components: [OneOrMore(CharacterClass.word)],
  ///     behavior: GroupBehavior.capture(),
  ///   ),
  /// ]); // (\w+)
  /// var str = 'Dash is a bird';
  /// Iterable<Match> matches = regex.allMatches(str, 8);
  /// for (final Match m in matches) {
  ///   String match = m[0]!;
  ///   print(match);
  /// }
  /// ```
  /// The output of the example is:
  /// ```
  /// a
  /// bird
  /// ```
  @override
  Iterable<RegExpMatch> allMatches(String input, [int start = 0]) {
    return _toRegExp().allMatches(input, start);
  }

  @override
  Match? matchAsPrefix(String string, [int start = 0]) {
    return _toRegExp().matchAsPrefix(string, start);
  }
}
