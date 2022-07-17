import 'package:regex_builder/regex_builder.dart';
import 'package:test/test.dart';

void main() {
  group('atLeast', () {
    group('quantifier', () {
      test('simple quantifier', () {
        const quantifier = Repeat(Regex('a'), range: RepeatRange.atLeast(3));
        expect(quantifier.quantifier, '{3,}');
      });

      test('greedy quantifier', () {
        const quantifier = Repeat(
          Regex('a'),
          range: RepeatRange.atLeast(3),
          greedy: false,
        );
        expect(quantifier.quantifier, '{3,}');
        expect(quantifier.pattern, 'a{3,}?');
      });
    });

    group('group', () {
      group('builder', () {
        test('simple regex', () {
          final regex =
              Repeat(CharacterClass('a'), range: RepeatRange.atLeast(3));
          expect(regex.pattern, 'a{3,}');
        });

        test('composed regex', () {
          final regex = Repeat(
            Group(components: [
              CharacterClass('a'),
              CharacterClass('b'),
            ]),
            range: RepeatRange.atLeast(3),
          );
          expect(regex.pattern, '(?:ab){3,}');
        });

        test('group regex', () {
          final regex = Repeat(
            Group(components: [
              CharacterClass('a'),
              CharacterClass('b'),
            ]),
            range: RepeatRange.atLeast(3),
          );
          expect(regex.pattern, '(?:ab){3,}');
        });

        test('character class union regex', () {
          final regex = Repeat(
            CharacterClass.union([
              CharacterClass('a'),
              CharacterClass('b'),
            ]),
            range: RepeatRange.atLeast(3),
          );
          expect(regex.pattern, '[ab]{3,}');
        });
      });

      group('pattern', () {
        test('simple regex', () {
          const regex = Repeat(Regex('a'), range: RepeatRange.atLeast(3));
          expect(regex.pattern, 'a{3,}');
        });

        test('composed regex', () {
          const regex = Repeat(Regex('ab'), range: RepeatRange.atLeast(3));
          expect(regex.pattern, '(?:ab){3,}');
        });
      });
    });
  });

  group('between', () {
    group('quantifier', () {
      test('simple quantifier', () {
        const quantifier = Repeat(Regex('a'), range: RepeatRange.exactly(4));
        expect(quantifier.quantifier, '{4}');
      });

      test('greedy quantifier', () {
        const quantifier = Repeat(
          Regex('a'),
          range: RepeatRange.exactly(4),
          greedy: false,
        );
        expect(quantifier.quantifier, '{4}');
        expect(quantifier.pattern, 'a{4}?');
      });
    });

    group('group', () {
      group('builder', () {
        test('simple regex', () {
          final regex =
              Repeat(CharacterClass('a'), range: RepeatRange.exactly(4));
          expect(regex.pattern, 'a{4}');
        });

        test('composed regex', () {
          final regex = Repeat(
            Group(components: [
              CharacterClass('a'),
              CharacterClass('b'),
            ]),
            range: RepeatRange.exactly(4),
          );
          expect(regex.pattern, '(?:ab){4}');
        });

        test('group regex', () {
          final regex = Repeat(
            Group(components: [
              CharacterClass('a'),
              CharacterClass('b'),
            ]),
            range: RepeatRange.exactly(4),
          );
          expect(regex.pattern, '(?:ab){4}');
        });

        test('character class union regex', () {
          final regex = Repeat(
            CharacterClass.union([
              CharacterClass('a'),
              CharacterClass('b'),
            ]),
            range: RepeatRange.exactly(4),
          );
          expect(regex.pattern, '[ab]{4}');
        });
      });

      group('pattern', () {
        test('simple regex', () {
          const regex = Repeat(Regex('a'), range: RepeatRange.exactly(4));
          expect(regex.pattern, 'a{4}');
        });

        test('composed regex', () {
          const regex = Repeat(Regex('ab'), range: RepeatRange.exactly(4));
          expect(regex.pattern, '(?:ab){4}');
        });
      });
    });
  });

  group('exactly', () {
    group('quantifier', () {
      test('simple quantifier', () {
        const quantifier = Repeat(Regex('a'), range: RepeatRange.exactly(4));
        expect(quantifier.quantifier, '{4}');
      });

      test('greedy quantifier', () {
        const quantifier = Repeat(
          Regex('a'),
          range: RepeatRange.exactly(4),
          greedy: false,
        );
        expect(quantifier.quantifier, '{4}');
        expect(quantifier.pattern, 'a{4}?');
      });
    });

    group('group', () {
      group('builder', () {
        test('simple regex', () {
          final regex =
              Repeat(CharacterClass('a'), range: RepeatRange.exactly(4));
          expect(regex.pattern, 'a{4}');
        });

        test('composed regex', () {
          final regex = Repeat(
            Group(components: [
              CharacterClass('a'),
              CharacterClass('b'),
            ]),
            range: RepeatRange.exactly(4),
          );
          expect(regex.pattern, '(?:ab){4}');
        });

        test('group regex', () {
          final regex = Repeat(
            Group(components: [
              CharacterClass('a'),
              CharacterClass('b'),
            ]),
            range: RepeatRange.exactly(4),
          );
          expect(regex.pattern, '(?:ab){4}');
        });

        test('character class union regex', () {
          final regex = Repeat(
            CharacterClass.union([
              CharacterClass('a'),
              CharacterClass('b'),
            ]),
            range: RepeatRange.exactly(4),
          );
          expect(regex.pattern, '[ab]{4}');
        });
      });

      group('pattern', () {
        test('simple regex', () {
          const regex = Repeat(Regex('a'), range: RepeatRange.exactly(4));
          expect(regex.pattern, 'a{4}');
        });

        test('composed regex', () {
          const regex = Repeat(Regex('ab'), range: RepeatRange.exactly(4));
          expect(regex.pattern, '(?:ab){4}');
        });
      });
    });
  });
}
