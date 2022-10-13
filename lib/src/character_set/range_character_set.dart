import 'character_set.dart';

class RangeCharacterSet extends CharacterSet {
  final String start;
  final String end;

  const RangeCharacterSet(this.start, this.end)
      : super.internal(requireBrackets: true);

  @override
  String get literalPattern => '$start-$end';
}
