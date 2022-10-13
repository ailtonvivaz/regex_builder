import '../regex_builder.dart';

/// Matches any character.
class AnyCharacter extends RegexComponent {
  @override
  String get pattern => '.';

  const AnyCharacter();
}
