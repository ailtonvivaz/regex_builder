import 'package:meta/meta.dart';

import 'quantifier.dart';

class Repeat extends Quantifier {
  final RepeatRange range;

  @override
  String get quantifier => range.quantifier;

  const Repeat(
    super.component, {
    required this.range,
    super.greedy,
  });
}

abstract class RepeatRange {
  String get quantifier;

  @internal
  const RepeatRange.internal();

  const factory RepeatRange.zeroOrMore() = ZeroOrMoreRepeatRange;

  const factory RepeatRange.oneOrMore() = OneOrMoreRepeatRange;

  const factory RepeatRange.optionally() = OptionallyRepeatRange;

  const factory RepeatRange.atLeast(int count) = AtLeastRepeatRange;

  const factory RepeatRange.atMost(int count) = AtMostRepeatRange;

  const factory RepeatRange.between(int min, int max) = BetweenRepeatRange;

  const factory RepeatRange.exactly(int count) = ExactlyRepeatRange;
}

class ZeroOrMoreRepeatRange extends RepeatRange {
  @override
  String get quantifier => '*';

  const ZeroOrMoreRepeatRange() : super.internal();
}

class OneOrMoreRepeatRange extends RepeatRange {
  @override
  String get quantifier => '+';

  const OneOrMoreRepeatRange() : super.internal();
}

class AtLeastRepeatRange extends RepeatRange {
  final int count;

  @override
  String get quantifier => '{$count,}';

  const AtLeastRepeatRange(this.count) : super.internal();
}

class AtMostRepeatRange extends BetweenRepeatRange {
  final int count;

  const AtMostRepeatRange(this.count) : super(0, count);
}

class BetweenRepeatRange extends RepeatRange {
  final int min;
  final int max;

  @override
  String get quantifier => '{$min,$max}';

  const BetweenRepeatRange(this.min, this.max) : super.internal();
}

class ExactlyRepeatRange extends RepeatRange {
  final int count;

  @override
  String get quantifier => '{$count}';

  const ExactlyRepeatRange(this.count) : super.internal();
}

class OptionallyRepeatRange extends RepeatRange {
  @override
  String get quantifier => '?';

  const OptionallyRepeatRange() : super.internal();
}
