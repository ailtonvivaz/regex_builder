import 'quantifier.dart';

/// Matches the [component] zero or more times.
class ZeroOrMore extends Quantifier {
  @override
  String get quantifier => '*';

  const ZeroOrMore(super.component, {super.greedy});
}
