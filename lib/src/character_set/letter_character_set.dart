import 'character_set.dart';

enum LetterCase { lower, upper }

class LetterCharacterSet extends CharacterSet {
  final LetterCase? letterCase;

  const LetterCharacterSet([this.letterCase])
      : super.internal(requireBrackets: true);

  @override
  String get literalPattern {
    switch (letterCase) {
      case LetterCase.lower:
        return 'a-z';
      case LetterCase.upper:
        return 'A-Z';
      default:
        return 'a-zA-Z';
    }
  }
}
