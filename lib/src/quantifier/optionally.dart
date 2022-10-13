import 'quantifier.dart';

/// Matches the [component] zero or one time.
class Optionally extends Quantifier {
  @override
  String get quantifier => '?';

  const Optionally(super.component, {super.greedy});
}
