import 'regex_component.dart';

enum LetterCase { lower, upper }

class CharacterClass extends RegexComponent {
  final String _pattern;

  @override
  String get pattern {
    if (_pattern.replaceAll(r'\', '').length == 1) {
      return _pattern;
    } else {
      return '[$_pattern]';
    }
  }

  const CharacterClass(this._pattern);

  factory CharacterClass.union(List<CharacterClass> components) {
    final pattern = components.map((c) => c._pattern).join('');
    return CharacterClass(pattern);
  }

  factory CharacterClass.negation(CharacterClass component) =>
      CharacterClass('^${component._pattern}');

  factory CharacterClass.range(String start, String end) =>
      CharacterClass('$start-$end');

  factory CharacterClass.letter([LetterCase? letterCase]) {
    return CharacterClass.union([
      if (letterCase == LetterCase.lower || letterCase == null)
        CharacterClass.range('a', 'z'),
      if (letterCase == LetterCase.upper || letterCase == null)
        CharacterClass.range('A', 'Z'),
    ]);
  }

  factory CharacterClass.number([int start = 0, int end = 9]) =>
      CharacterClass.range(start.toString(), end.toString());

  static const CharacterClass digit = CharacterClass(r'\d');
  static const CharacterClass word = CharacterClass(r'\w');
  static const CharacterClass whitespace = CharacterClass(r'\s');
  static const CharacterClass tab = CharacterClass(r'\t');
  static const CharacterClass newline = CharacterClass(r'\n');
  static const CharacterClass carriageReturn = CharacterClass(r'\r');
  static const CharacterClass backslash = CharacterClass(r'\\');
  static const CharacterClass dot = CharacterClass('.');
}
