import 'regex_component.dart';
import 'parent_regex_component.dart';

class Lookahead extends ParentRegexComponent with RegexComponentPatterned {
  @override
  String get pattern => '(?=${component.pattern})';

  Lookahead(super.component);
}

class NegativeLookahead extends ParentRegexComponent
    with RegexComponentPatterned {
  @override
  String get pattern => '(?!${component.pattern})';

  NegativeLookahead(super.component);
}
