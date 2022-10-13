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

A declarative way to write regular expressions in Dart. This package was inspired by [Swift RegexBuilder](https://developer.apple.com/documentation/regexbuilder).

> **Important:** This package is still in development and could change until the first stable release.

## Features

RegexBuilder conforms with [RegExp](https://api.flutter.dev/flutter/dart-core/RegExp-class.html), thus all methods and properties are available to use.

The following example finds all matches of HTML tags in a string.

```dart
final regex = RegexBuilder([
  Group([
    Literal('<'),                                   // <
    Group([
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
    OneOrMore(AnyCharacter(), greedy: false),       // .+?
    behavior: GroupBehavior.capture(),
  ),                                                // (.+?)
  Literal('</'),                                    // </
  Reference('tag'),                                 // \k<tag>
  Literal('>'),                                     // >
]);                                                 // <(?<tag>[a-z][a-zA-Z0-9]*)>(.+?)</\k<tag>>

final html = '<h1>Hello, world!</h1><a>Google</a>';

for (final match in regex.allMatches(html)) {
  print('All Match: ${match.group(0)}');
  print('Tag: ${match.group(1)}');
  print('Content: ${match.group(2)}');
}
```

The output of the example is:

```
All Match: <h1>Hello, world!</h1>
Tag: h1
Content: Hello, world!
All Match: <a>Google</a>
Tag: a
Content: Google
```

## Components

A RegexBuilder is composed of a list of components. The following components are available:

- [Literal](#literal)
- [Wildcards](#wildcards)
- [Alternation](#alternation)
- [Quantifiers](#quantifiers)
  - [ZeroOrMore](#zeroormore)
  - [OneOrMore](#oneormore)
  - [Optionally](#optionally)
  - [Repeat](#repeat)
- [CharacterSet](#characterset)
- [Group](#group)
  - [Capture](#capture)
- [Anchor](#anchor)

### Literal

A literal is a string of characters that must be matched exactly.

```dart
Literal('abc'); // This represents the pattern 'abc'
```

### Wildcards

A wildcard is a character that matches any character.

```dart
AnyCharacter(); // This represents the pattern '.'
```

> **Note:** In order to match a literal dot, use the Literal component `Literal('.')`.

### Alternation

An alternation is a list of components that could match any of them.

```dart
ChoiceOf([
  Literal('cat'),
  Literal('dog'),
]); // This represents the pattern 'cat|dog'
```

### Quantifiers

Quantifiers are used to specify how many times a component should be matched.

#### ZeroOrMore

Matches zero or one time.

```dart
ZeroOrMore(Literal('a')); // This represents the pattern 'a*'
```

#### OneOrMore

Matches one or more times.

```dart
OneOrMore(Literal('a')); // This represents the pattern 'a+'
```

#### Optionally

Matches zero or one time.

```dart
Optionally(Literal('a')); // This represents the pattern 'a?'
```

#### Repeat

Matches a specific number of times.

```dart
Repeat(
  Literal('a'),
  range: RepeatRange.atLeast(3),
); // This represents the pattern 'a{3,}'

Repeat(
  Literal('a'),
  range: RepeatRange.atMost(3),
); // This represents the pattern 'a{0,3}'

Repeat(
  Literal('a'),
  range: RepeatRange.exactly(3),
); // This represents the pattern 'a{3}'

Repeat(
  Literal('a'),
  range: RepeatRange.between(3, 5),
); // This represents the pattern 'a{3,5}'
```

### CharacterSet

### Group

A group is a list of components that must be matched together.
By default, a group is non-capturing.

```dart
Group([
  Literal('a'),
  Literal('b'),
]); // This represents the pattern '(?:ab)'
```

#### Capture

A capture group is a list of components that must be matched together and will be captured.

```dart
Group([
  Literal('a'),
  Literal('b'),
], behavior: GroupBehavior.capture()); // This represents the pattern '(ab)'

Group([
  Literal('a'),
  Literal('b'),
], behavior: GroupBehavior.capture('group_name')); // This represents the pattern '(?<group_name>ab)'
```

### Anchor

An anchor is a component that matches the beginning or end of a string.

```dart
Anchor.startOfLine; // This represents the pattern '^'
Anchor.endOfLine; // This represents the pattern '$'
```
