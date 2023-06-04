import 'package:regex_builder/regex_builder.dart';
import 'package:test/test.dart';

void main() {
  group('LookAhead', () {
    test('positive literal', () {
      final regex = RegexBuilder([
        LookAhead([Literal('a')], positive: true),
        Literal('b')
      ]);
      expect(regex.pattern, '(?=a)b');
    });

    test('negative literal', () {
      final regex = RegexBuilder([
        LookAhead([Literal('a')], positive: false),
        Literal('b')
      ]);
      expect(regex.pattern, '(?!a)b');
    });

    test('positive character set', () {
      final regex = RegexBuilder([
        LookAhead([CharacterSet.letter('a')]),
        Literal('b')
      ]);
      expect(regex.pattern, '(?=[a])b');
    });

    test('negative character set', () {
      final regex = RegexBuilder([
        LookAhead([CharacterSet.letter('a')], positive: false),
        Literal('b')
      ]);
      expect(regex.pattern, '(?![a])b');
    });

    test('positive group', () {
      final regex = RegexBuilder([
        LookAhead([
          Group([Literal('a'), Literal('b')])
        ], positive: true),
        Literal('c')
      ]);
      expect(regex.pattern, '(?=(?:ab))c');
    });

    test('negative group', () {
      final regex = RegexBuilder([
        LookAhead([
          Group([Literal('a'), Literal('b')])
        ], positive: false),
        Literal('c')
      ]);
      expect(regex.pattern, '(?!(?:ab))c');
    });
  });
}

