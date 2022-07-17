import 'regex_component.dart';

class Lookahead extends ParentRegexComponent {
  @override
  String get pattern => '(?=${component.pattern})';

  Lookahead(super.component);
}

class NegativeLookahead extends ParentRegexComponent {
  @override
  String get pattern => '(?!${component.pattern})';

  NegativeLookahead(super.component);
}

class Lookbehind extends ParentRegexComponent {
  @override
  String get pattern => '(?<=${component.pattern})';

  Lookbehind(super.component);
}

class NegativeLookbehind extends ParentRegexComponent {
  @override
  String get pattern => '(?<!${component.pattern})';

  NegativeLookbehind(super.component);
}
