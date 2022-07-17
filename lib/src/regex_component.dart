import 'character_class.dart';
import 'group.dart';
import 'regex.dart';

abstract class RegexComponent {
  String get pattern => regex.pattern;

  Regex get regex;

  bool get isUnitary {
    return [Group, CharacterClass].contains(runtimeType) ||
        pattern.replaceAll(r'\', '').length == 1;
  }

  const RegexComponent();

  @override
  String toString() => pattern;
}

typedef RegexComponents = Iterable<RegexComponent>;

extension RegexComponentsExtension on RegexComponents {
  String get pattern => patterns.join();

  List<String> get patterns => map((c) => c.pattern).toList();
}

mixin RegexComponentPatterned on RegexComponent {
  @override
  String get pattern;

  @override
  Regex get regex => Regex(pattern);
}
