import 'regex_component.dart';
import 'parent_regex_component.dart';

class Lookbehind extends ParentRegexComponent with RegexComponentPatterned {
  @override
  String get pattern => '(?<=${component.pattern})';

  Lookbehind(super.component);
}

class NegativeLookbehind extends ParentRegexComponent
    with RegexComponentPatterned {
  @override
  String get pattern => '(?<!${component.pattern})';

  NegativeLookbehind(super.component);
}
