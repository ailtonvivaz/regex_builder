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

A declarative way to write regular expressions in Dart.

## Features

A declarative builder for Regex.

## Getting started

Regex conforms with [Pattern](https://api.flutter.dev/flutter/dart-core/Pattern-class.html), thus all


## Usage



```dart
final usernameRegex = Regex.builder(
  components: [
    Anchor.startOfLine,                             // ^
    Repeat(
      CharacterSet([
        CharacterSet.letter(LetterCase.lower),      // [a-z]
        CharacterSet.number(0, 9),                  // [0-9]
        CharacterSet.literal('_-'),                 // [_-]
      ]),                                           // [a-z0-9_-]
      range: RepeatRange.between(3, 16),
    ),                                              // [a-z0-9_-]{3,16}
    Anchor.endOfLine,                               // $
  ],
);                                                  // ^[a-z0-9_-]{3,16}$
```

```dart
final letterAndNumbers = CharacterSet([
  CharacterSet.letter(LetterCase.lower),            // [a-z]
  CharacterSet.number(0, 9),                        // [0-9]
]);                                                 // [a-z0-9]

final regex = Regex.builder(
  components: [
    Anchor.startOfLine,                             // ^
    OneOrMore(
      CharacterSet([
        letterAndNumbers,                           // [a-z0-9]
        CharacterSet.literal('.'),                  // [.]
      ]),                                           // [a-z0-9.]
    ),                                              // [a-z0-9.]+
    Literal('@'),                                   // @
    OneOrMore(letterAndNumbers),                    // [a-z0-9]+
    Literal('.'),                                   // \.
    OneOrMore(
      CharacterSet.letter(LetterCase.lower)         // [a-z]
    ),                                              // [a-z]+
    Optionally(Group([
      Literal('.'),                                 // \.
      OneOrMore(
        CharacterSet.letter(LetterCase.lower)       // a-z
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
  Group([
    Literal('<'),                                   // <
    Group(
      components: [
        CharacterSet.letter(LetterCase.lower),      // [a-z]
        ZeroOrMore(
          CharacterSet([
            CharacterSet.letter(),                  // [a-zA-Z]
            CharacterSet.number(0, 9),              // [0-9]
          ]),                                       // [a-zA-Z0-9]
        ),                                          // [a-zA-Z0-9]*
      ],                                            // [a-z][a-zA-Z0-9]*
      behavior: GroupBehavior.capture('tag'),
    ),                                              // (?<tag>[a-z][a-zA-Z0-9]*)?
    Literal('>'),                                   // >
  ]),                                               // <(?<tag>[a-z][a-zA-Z0-9]*)>
  Group(
    OneOrMore(AnyCharacter(), greedy: false),          // .+?
    behavior: GroupBehavior.capture(),
  ),                                                // (.+?)
  Literal('</'),                                    // </
  Reference('tag'),                                 // \k<tag>
  Literal('>'),                                     // >
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

