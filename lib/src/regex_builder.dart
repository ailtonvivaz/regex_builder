import 'regex_component.dart';

class RegexBuilder implements RegExp {
  final List<RegexComponent> components;

  @override
  final bool isMultiLine;

  @override
  final bool isCaseSensitive;

  @override
  String get pattern {
    final lookAheads = <String>[];
    final otherComponents = <String>[];

    for (final component in components) {
      if (component is LookAhead) {
        lookAheads.add(component.pattern);
      } else {
        otherComponents.add(component.pattern);
      }
    }

    return '${lookAheads.join()}${otherComponents.join()}';
  }

  @override
  String get pattern => components.map((e) => e.pattern).join();

  RegExp get regExp => RegExp(pattern);

  @override
  Iterable<RegExpMatch> allMatches(String input, [int start = 0]) =>
      regExp.allMatches(input, start);

  @override
  RegExpMatch? firstMatch(String input) => regExp.firstMatch(input);

  @override
  bool hasMatch(String input) => regExp.hasMatch(input);

  @override
  Match? matchAsPrefix(String string, [int start = 0]) =>
      regExp.matchAsPrefix(string, start);

  @override
  String? stringMatch(String input) => regExp.stringMatch(input);
}
