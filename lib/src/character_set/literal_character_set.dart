import 'character_set.dart';

class LiteralCharacterSet extends CharacterSet {
  final String literal;

  const LiteralCharacterSet(
    this.literal, {
    super.requireBrackets,
  }) : super.internal();

  @override
  String get literalPattern => literal;
}
