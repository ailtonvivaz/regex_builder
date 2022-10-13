import '../regex_builder.dart';

class AnyCharacter extends RegexComponent {
  @override
  String get pattern => '.';

  const AnyCharacter();
}
