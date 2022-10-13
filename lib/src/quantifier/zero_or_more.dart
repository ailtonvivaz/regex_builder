import 'quantifier.dart';

class ZeroOrMore extends Quantifier {
  @override
  String get quantifier => '*';

  const ZeroOrMore(super.component, {super.greedy});
}
