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

  group('lookahead', () {
    test('match with lookahead', () {
      final regex = RegexBuilder([
        LookAhead([Literal('foo')]),
        Literal('bar')
      ]);

      expect(regex.hasMatch('foobar'), isTrue);
    });

    test('no match without lookahead', () {
      final regex = RegexBuilder([
        Literal('bar')
      ]);

      expect(regex.hasMatch('foobar'), isFalse);
    });
  });

  test('common regex', () {
    // Rest of code...
  });  
}
