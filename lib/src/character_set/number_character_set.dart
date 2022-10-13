import 'character_set.dart';

class NumberCharacterSet extends CharacterSet {
  final int number;
  final int? max;

  const NumberCharacterSet(this.number, [this.max])
      : super.internal(requireBrackets: max != null);

  @override
  String get literalPattern {
    if (max != null) {
      return '$number-$max';
    } else {
      return '$number';
    }
  }
}
