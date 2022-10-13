import 'package:regex_builder/regex_builder.dart';
import 'package:test/test.dart';

void main() {
  group('quantifier', () {
    test('simple quantifier', () {
      const quantifier = Optionally(Literal('a'));
      expect(quantifier.quantifier, '?');
    });

    test('greedy quantifier', () {
      const quantifier = Optionally(Literal('a'), greedy: false);
      expect(quantifier.quantifier, '?');
      expect(quantifier.pattern, 'a??');
    });
  });

  group('group', () {
    group('builder', () {
      test('simple regex', () {
        final regex = Optionally(CharacterSet.literal('a'));
        expect(regex.pattern, 'a?');
      });

      test('composed regex', () {
        final regex = Optionally(Group([
          CharacterSet.literal('a'),
          CharacterSet.literal('b'),
        ]));
        expect(regex.pattern, '(?:ab)?');
      });

      test('group regex', () {
        final regex = Optionally(Group([
          CharacterSet.literal('a'),
          CharacterSet.literal('b'),
        ]));
        expect(regex.pattern, '(?:ab)?');
      });

      test('character class union regex', () {
        final regex = Optionally(CharacterSet([
          CharacterSet.literal('a'),
          CharacterSet.literal('b'),
        ]));
        expect(regex.pattern, '[ab]?');
      });
    });

    group('pattern', () {
      test('simple regex', () {
        const regex = Optionally(Literal('a'));
        expect(regex.pattern, 'a?');
      });

      test('composed regex', () {
        const regex = Optionally(Literal('ab'));
        expect(regex.pattern, '(?:ab)?');
      });
    });
  });
}
