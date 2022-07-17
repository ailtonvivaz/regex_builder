import 'package:regex_builder/regex_builder.dart';
import 'package:test/test.dart';

void main() {
  group('quantifier', () {
    test('simple quantifier', () {
      const quantifier = ZeroOrMore(Regex('a'));
      expect(quantifier.quantifier, '*');
    });

    test('greedy quantifier', () {
      const quantifier = ZeroOrMore(Regex('a'), greedy: false);
      expect(quantifier.quantifier, '*');
      expect(quantifier.pattern, 'a*?');
    });
  });

  group('group', () {
    group('builder', () {
      test('simple regex', () {
        final regex = ZeroOrMore(CharacterClass('a'));
        expect(regex.pattern, 'a*');
      });

      test('composed regex', () {
        final regex = ZeroOrMore(Group(components: [
          CharacterClass('a'),
          CharacterClass('b'),
        ]));
        expect(regex.pattern, '(?:ab)*');
      });

      test('group regex', () {
        final regex = ZeroOrMore(Group(components: [
          CharacterClass('a'),
          CharacterClass('b'),
        ]));
        expect(regex.pattern, '(?:ab)*');
      });

      test('character class union regex', () {
        final regex = ZeroOrMore(CharacterClass.union([
          CharacterClass('a'),
          CharacterClass('b'),
        ]));
        expect(regex.pattern, '[ab]*');
      });
    });

    group('pattern', () {
      test('simple regex', () {
        const regex = ZeroOrMore(Regex('a'));
        expect(regex.pattern, 'a*');
      });

      test('composed regex', () {
        const regex = ZeroOrMore(Regex('ab'));
        expect(regex.pattern, '(?:ab)*');
      });
    });
  });
}
