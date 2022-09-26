import 'package:regex_builder/regex_builder.dart';
import 'package:regex_builder/src/reference.dart';
import 'package:test/test.dart';

void main() {
  test('email', () {
    final letterAndNumbers = CharacterClass.union([
      CharacterClass.letter(LetterCase.lower),
      CharacterClass.number(),
    ]);

    final emailRegex = Regex.builder(
      components: [
        Anchor.startOfLine,
        OneOrMore(
          CharacterClass.union([
            letterAndNumbers,
            CharacterClass.dot,
          ]),
        ),
        Regex.literal('@'),
        OneOrMore(letterAndNumbers),
        Regex.literal('.'),
        OneOrMore(CharacterClass.letter(LetterCase.lower)),
        Optionally(Group(components: [
          Regex.literal('.'),
          OneOrMore(CharacterClass.letter(LetterCase.lower)),
        ])),
        Anchor.endOfLine,
      ],
      caseSensitive: false,
      multiLine: true,
    );

    print(emailRegex.pattern);

    const expected = r'^[a-z0-9.]+@[a-z0-9]+\.[a-z]+(?:\.[a-z]+)?$';

    print(expected);

    expect(emailRegex.pattern, expected);

//     final regex = emailRegex.regExp;
//     // RegExp('^${emailRegex.regExp.pattern}\$');

//     //validate
//     final emailTests = [
//       'foo.bar@gmail.cAm',
//       'foo.bar@gmail.com.br',
//       'foo.bar@gmail.com.br.br',
//       'foo.bar@gmail.',
//       'foo.bar@gmailcom',
//       'foo.bargmail.com',
//       '@gmail.com',
//       '''
// foo.bar@gmail.com.br
// foo.bar@gmail.com
// foo.bar@gmail.com.br.br
// foo.bar@gmail.
// foo.bar@gmailcom
// foo.bargmail.com
// @gmail.com
// '''
//     ];

//     for (final email in emailTests) {
//       // print('$email: ${regex.hasMatch(email)}');
//       final matches = regex.allMatches(email);
//       for (final match in matches) {
//         // print('Match: ${match.start}, ${match.end}');
//         print(email.substring(match.start, match.end));
//       }
//     }
  });

  test('capture', () {
    final domain = Regex.builder(components: [
      Group(components: [
        Regex.literal('<'),
        Group(
          components: [
            CharacterClass.letter(LetterCase.lower),
            ZeroOrMore(
              CharacterClass.union([
                CharacterClass.letter(),
                CharacterClass.number(),
              ]),
            ),
          ],
          behavior: GroupBehavior.capture('tag'),
        ),
        Regex.literal('>'),
      ]),
      Group(
        components: [OneOrMore(Regex.any(), greedy: false)],
        behavior: GroupBehavior.capture(),
      ),
      Regex.literal('</'),
      Reference('tag'),
      Regex.literal('>'),
    ]);

    const url = '<h1>Hello, world!</h1><a>Google</a>';

    print(domain.pattern);

    for (final match in domain.allMatches(url)) {
      print('Content: ${match.group(0)}');
      print('Tag: ${match.group(1)}');
      print('Value: ${match.group(2)}');
    }

    // final value = domain.allMatches(url).map((e) => e.groups([0, 1, 2]));
    // print(value);
  });

  test('anyOf', () {
    final regex = AnyOf([
      CharacterClass('a'),
      CharacterClass('e'),
      CharacterClass('i'),
      CharacterClass('o'),
      CharacterClass('u'),
    ]).regex;
    final alphabet = 'abcdefghijklmnopqrstuvwxyz';
    final result = alphabet.replaceAll(regex, '-');

    print(regex);
    print(result);
  });

  test('anyOf multiple', () {
    final regex = Regex.builder(components: [
      Regex.literal('Data'),
      CharacterClass.whitespace,
      AnyOf([
        Regex.literal('Analysis'),
        Regex.literal('Base'),
        Regex.literal('Analytics'),
      ]),
    ]);

    final expected = r'Data\s(?:Analysis|Base|Analytics)';
    print(regex.pattern);
    expect(regex.pattern, expected);
  });

  test('reference', () {
    final regex = Regex.builder(components: [
      Group(
        components: [OneOrMore(CharacterClass.word)],
        behavior: GroupBehavior.capture('title'),
      ),
      Regex.literal(', yes '),
      Reference('title'),
    ]);

    final input = 'Sir, yes Sir';
    print(regex.pattern);

    expect(regex.hasMatch(input), isTrue);
  });

  test('common regex', () {
    final username = Regex.builder(
      components: [
        Anchor.startOfLine,
        Repeat(
          CharacterClass.union([
            CharacterClass.letter(LetterCase.lower),
            CharacterClass.number(),
            CharacterClass('_-'),
          ]),
          range: RepeatRange.between(3, 16),
        ),
        Anchor.endOfLine,
      ],
    );

    print(username);
  });

  test('doc', () {
    final regex = Regex.builder(components: [
      Group(
        components: [
          OneOrMore(CharacterClass.word),
        ],
        behavior: GroupBehavior.capture(),
      ),
    ]);
    var str = 'Dash is a bird';
    Iterable<Match> matches = regex.allMatches(str, 8);
    for (final Match m in matches) {
      String match = m[0]!;
      print(match);
    }

    print(regex.pattern);
  });
}
