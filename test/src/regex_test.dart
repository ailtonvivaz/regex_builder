import 'package:regex_builder/regex_builder.dart';
import 'package:test/test.dart';

void main() {
  test('email', () {
    final letterAndNumbers = CharacterSet([
      CharacterSet.letter(LetterCase.lower),
      CharacterSet.number(0, 9),
    ]);

    final emailRegex = RegexBuilder(
      [
        Anchor.startOfLine,
        OneOrMore(
          CharacterSet([
            letterAndNumbers,
            CharacterSet.literal('.'),
          ]),
        ),
        Literal('@'),
        OneOrMore(letterAndNumbers),
        Literal('.'),
        OneOrMore(CharacterSet.letter(LetterCase.lower)),
        Optionally(Group([
          Literal('.'),
          OneOrMore(CharacterSet.letter(LetterCase.lower)),
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
    final domain = RegexBuilder([
      Group([
        Literal('<'),
        Group(
          [
            CharacterSet.letter(LetterCase.lower),
            ZeroOrMore(
              CharacterSet([
                CharacterSet.letter(),
                CharacterSet.digit,
              ]),
            ),
          ],
          behavior: GroupBehavior.capture('tag'),
        ),
        Literal('>'),
      ]),
      Group([OneOrMore(AnyCharacter(), greedy: false)],
          behavior: GroupBehavior.capture()),
      Literal('</'),
      Reference('tag'),
      Literal('>'),
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
    final regex = ChoiceOf([
      CharacterSet.literal('a'),
      CharacterSet.literal('e'),
      CharacterSet.literal('i'),
      CharacterSet.literal('o'),
      CharacterSet.literal('u'),
    ]).pattern;
    final alphabet = 'abcdefghijklmnopqrstuvwxyz';
    final result = alphabet.replaceAll(regex, '-');

    print(regex);
    print(result);
  });

  test('anyOf multiple', () {
    final regex = RegexBuilder([
      Literal('Data'),
      CharacterSet.whitespace,
      ChoiceOf([
        Literal('Analysis'),
        Literal('Base'),
        Literal('Analytics'),
      ]),
    ]);

    final expected = r'Data\s(?:Analysis|Base|Analytics)';
    print(regex.pattern);
    expect(regex.pattern, expected);
  });

  test('reference', () {
    final regex = RegexBuilder([
      Group(
        [OneOrMore(CharacterSet.word)],
        behavior: GroupBehavior.capture('title'),
      ),
      Literal(', yes '),
      Reference('title'),
    ]);

    final input = 'Sir, yes Sir';
    print(regex.pattern);

    expect(regex.hasMatch(input), isTrue);
  });

  test('common regex', () {
    final username = RegexBuilder(
      [
        Anchor.startOfLine,
        Repeat(
          CharacterSet([
            CharacterSet.letter(LetterCase.lower),
            CharacterSet.digit,
            CharacterSet.literal('_-'),
          ]),
          range: RepeatRange.between(3, 16),
        ),
        Anchor.endOfLine,
      ],
    );

    print(username);
  });

  test('doc', () {
    final regex = RegexBuilder([
      Group([
        OneOrMore(CharacterSet.word),
      ], behavior: GroupBehavior.capture()),
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
