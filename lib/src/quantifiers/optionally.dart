import 'quantifier.dart';

class Optionally extends Quantifier {
  @override
  String get quantifier => '?';

  const Optionally(super.component, {super.greedy});
}
