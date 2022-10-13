import 'package:meta/meta.dart';

import '../regex_component.dart';
import 'group_character_set.dart';
import 'letter_character_set.dart';
import 'literal_character_set.dart';
import 'number_character_set.dart';
import 'range_character_set.dart';

abstract class CharacterSet extends RegexComponent {
  final bool negate;
  final bool requireBrackets;

  @override
  String get pattern {
    final literalPattern = '${negate ? '^' : ''}${this.literalPattern}';
    return requireBrackets ? '[$literalPattern]' : literalPattern;
  }

  String get literalPattern;

  @internal
  const CharacterSet.internal({
    this.negate = false,
    this.requireBrackets = false,
  });

  const factory CharacterSet(List<CharacterSet> components, {bool negate}) =
      GroupCharacterSet;

  const factory CharacterSet.literal(String pattern) = LiteralCharacterSet;

  const factory CharacterSet.letter([LetterCase? letterCase]) =
      LetterCharacterSet;
  const factory CharacterSet.number(int number, [int? max]) =
      NumberCharacterSet;

  static const CharacterSet word = LiteralCharacterSet(r'\w');
  static const CharacterSet digit = LiteralCharacterSet(r'\d');

  static const CharacterSet whitespace = LiteralCharacterSet(r'\s');

  static const CharacterSet backspace = LiteralCharacterSet(
    '\b',
    requireBrackets: true,
  );

  const factory CharacterSet.range(
    String start,
    String end,
  ) = RangeCharacterSet;
}
