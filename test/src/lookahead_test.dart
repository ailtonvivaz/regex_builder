import 'package:regex_builder/regex_builder.dart';
import 'package:test/test.dart';

void main() {
  group('LookAhead', () {
    test('returns correct pattern', () {
      final lookahead = LookAhead([Literal('a'), Literal('b')]);
      expect(lookahead.pattern, '?=ab');
    });
    
    test('does not consume input', () {
      final lookahead = LookAhead([Literal('a'), Literal('b')]);
      final input = 'abc';
      lookahead.match(input);
      expect(input, 'abc');
    });
  });
}

