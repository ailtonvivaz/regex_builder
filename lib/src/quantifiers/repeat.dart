import 'quantifier.dart';

class Repeat extends Quantifier {
  final RepeatRange range;

  @override
  String get quantifier {
    final min = range.min;
    final max = range.max;
    if (max == null) {
      if (min == 1) {
        return '+';
      } else if (min == 0) {
        return '*';
      } else {
        return '{$min,}';
      }
    } else if (min == max) {
      return '{$min}';
    } else {
      return '{$min,$max}';
    }
  }

  const Repeat(
    super.component, {
    required this.range,
    super.greedy,
  });
}

class RepeatRange {
  final int min;
  final int? max;

  const RepeatRange._(this.min, [this.max]);

  const RepeatRange.exactly(int count) : this._(count, count);

  const RepeatRange.atLeast(int count) : this._(count, null);

  const RepeatRange.between(int min, int max) : this._(min, max);
}
