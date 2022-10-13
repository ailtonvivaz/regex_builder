import 'package:meta/meta.dart';

import 'quantifier.dart';

/// Matches the [component] a specific number of times.
///
/// The amount of times is defined by [range].
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

  /// Matches the [component] zero or more times.
  const factory RepeatRange.zeroOrMore() = ZeroOrMoreRepeatRange;

  /// Matches the [component] one or more times.
  const factory RepeatRange.oneOrMore() = OneOrMoreRepeatRange;

  /// Matches the [component] zero or one time.
  const factory RepeatRange.optionally() = OptionallyRepeatRange;

  /// Matches the [component] at least [count] times.
  const factory RepeatRange.atLeast(int count) = AtLeastRepeatRange;

  /// Matches the [component] at most [count] times.
  const factory RepeatRange.atMost(int count) = AtMostRepeatRange;

  /// Matches the [component] between [min] and [max] times.
  const factory RepeatRange.between(int min, int max) = BetweenRepeatRange;

  /// Matches the [component] exactly [count] times.
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
