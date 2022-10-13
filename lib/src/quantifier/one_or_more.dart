import 'quantifier.dart';

/// Matches the [component] one or more times.
class OneOrMore extends Quantifier {
  @override
  String get quantifier => '+';

  const OneOrMore(super.component, {super.greedy});
}
