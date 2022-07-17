<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
final regex = Regex.builder(
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

// regex: ^[a-z0-9_-]{3,16}$
```

```dart
final letterAndNumbers = CharacterClass.union([
  CharacterClass.letter(LetterCase.lower),
  CharacterClass.number(),
]);

final regex = Regex.builder(
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
    Optionally(Regex.builder(
      components: [
        Regex.literal('.'),
        OneOrMore(CharacterClass.letter(LetterCase.lower)),
      ],
    )),
    Anchor.endOfLine,
  ],
  caseSensitive: false,
  multiLine: true,
);

// regex: ^[a-z0-9.]+@[a-z0-9]+\.[a-z]+(?:\.[a-z]+)?$
```

```dart
final html = Regex.builder(components: [
  Capture(
    Regex.builder(components: [
      Regex.literal('<'),
      Capture(
        Regex.builder(
          components: [
            CharacterClass.letter(LetterCase.lower),
            ZeroOrMore(
              CharacterClass.union([
                CharacterClass.letter(),
                CharacterClass.number(),
              ]),
            ),
          ],
        ),
        name: 'tag',
      ),
      Regex.literal('>'),
    ]),
  ),
  Capture(OneOrMore(Regex.any(), greedy: false)),
  Regex.literal('</'),
  Reference('tag'),
  Regex.literal('>'),
]);

final value = domain
    .allMatches(url)
    .map((e) => e.groups(List.generate(e.groupCount, (index) => index + 1)))
    .toList();

// regex: (<(?<tag>[a-z][a-zA-Z0-9]*)>)(.+?)</\k<tag>>
// value: [[<h1>, h1, Hello, world!], [<a>, a, Google]]
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
