import 'quantifier.dart';

class OneOrMore extends Quantifier {
  @override
  String get quantifier => '+';

  const OneOrMore(super.component, {super.greedy});
}
