import 'package:meta/meta.dart';

import 'regex.dart';

abstract class RegexComponent {
  String get pattern;

  @nonVirtual
  Regex get regex => Regex(pattern);

  const RegexComponent();

  @override
  String toString() => pattern;
}

typedef RegexComponents = Iterable<RegexComponent>;

extension RegexComponentsExtension on RegexComponents {
  String get pattern => map((c) => c.pattern).join();
}

abstract class ParentRegexComponent extends RegexComponent {
  final RegexComponent component;

  const ParentRegexComponent(this.component);
}
