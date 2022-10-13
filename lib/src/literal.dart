import 'regex_component.dart';

class Literal extends RegexComponent {
  final String literal;

  const Literal(this.literal);

  @override
  String get pattern {
    final pattern =
        literal.replaceAllMapped(RegExp(r'([\\^$.|?*+()[{]|\])'), (match) {
      return '\\${match.group(0)}';
    }).replaceAllMapped(RegExp(r'(\\s)'), (match) {
      return '\\s';
    }).replaceAllMapped(RegExp(r'(\\d)'), (match) {
      return '\\d';
    }).replaceAllMapped(RegExp(r'(\\w)'), (match) {
      return '\\w';
    });

    return pattern;
  }
}
