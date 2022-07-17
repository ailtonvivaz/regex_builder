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

A declarative builder for Regex.

## Features

A declarative builder for Regex.

## Getting started



## Usage



```dart
final usernameRegex = Regex.builder(
  components: [
    Anchor.startOfLine,                             // ^
    Repeat(
      CharacterClass.union([
        CharacterClass.letter(LetterCase.lower),    // [a-z]
        CharacterClass.number(),                    // [0-9]
        CharacterClass('_-'),                       // [_-]
      ]),                                           // [a-z0-9_-]
      range: RepeatRange.between(3, 16),
    ),                                              // [a-z0-9_-]{3,16}
    Anchor.endOfLine,                               // $
  ],
);                                                  // ^[a-z0-9_-]{3,16}$
```

```dart
final letterAndNumbers = CharacterClass.union([
  CharacterClass.letter(LetterCase.lower),          // [a-z]
  CharacterClass.number(),                          // [0-9]
]);                                                 // [a-z0-9]

final regex = Regex.builder(
  components: [
    Anchor.startOfLine,                             // ^
    OneOrMore(
      CharacterClass.union([
        letterAndNumbers,                           // [a-z0-9]
        CharacterClass.dot,                         // [.]
      ]),                                           // [a-z0-9.]
    ),                                              // [a-z0-9.]+
    Regex.literal('@'),                             // @
    OneOrMore(letterAndNumbers),                    // [a-z0-9]+
    Regex.literal('.'),                             // \.
    OneOrMore(
      CharacterClass.letter(LetterCase.lower)       // [a-z]
    ),                                              // [a-z]+
    Optionally(Group([
      Regex.literal('.'),                           // \.
      OneOrMore(
        CharacterClass.letter(LetterCase.lower)     // a-z
      ),                                            // [a-z]+
    ])),                                            // (?:\.[a-z])+?
    Anchor.endOfLine,                               // $
  ],
  caseSensitive: false,
  multiLine: true,
);                                                  // ^[a-z0-9.]+@[a-z0-9]+\.[a-z]+(?:\.[a-z]+)?$
```

```dart
final regex = Regex.builder(components: [
  Group(components: [
    Regex.literal('<'),                             // <
    Group(
      components: [
        CharacterClass.letter(LetterCase.lower),    // [a-z]
        ZeroOrMore(
          CharacterClass.union([
            CharacterClass.letter(),                // [a-zA-Z]
            CharacterClass.number(),                // [0-9]
          ]),                                       // [a-zA-Z0-9]
        ),                                          // [a-zA-Z0-9]*
      ],                                          // [a-z][a-zA-Z0-9]*
      behavior: GroupBehavior.capture('tag'),
    ),                                              // (?<tag>[a-z][a-zA-Z0-9]*)?
    Regex.literal('>'),                             // >
  ]),                                               // <(?<tag>[a-z][a-zA-Z0-9]*)>
  Group(
    OneOrMore(Regex.any(), greedy: false),          // .+?
    behavior: GroupBehavior.capture(),
  ),                                                // (.+?)
  Regex.literal('</'),                              // </
  Reference('tag'),                                 // \k<tag>
  Regex.literal('>'),                               // >
]);                                                 // <(?<tag>[a-z][a-zA-Z0-9]*)>(.+?)</\k<tag>>

final html = '<h1>Hello, world!</h1><a>Google</a>';

for (final match in regex.allMatches(html)) {
  print('Content: ${match.group(0)}');
  print('Tag: ${match.group(1)}');
  print('Value: ${match.group(2)}');
}

// Output
// Content: <h1>Hello, world!</h1>
// Tag: h1
// Value: Hello, world!
// Content: <a>Google</a>
// Tag: a
// Value: Google
```

## Additional information

