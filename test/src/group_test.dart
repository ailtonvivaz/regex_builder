import 'package:regex_builder/regex_builder.dart';
import 'package:test/test.dart';

void main() {
  test('one component', () {
    final group = Group(components: [CharacterClass('a')]);
    expect(group.pattern, '(?:a)');
  });

  test('multiple components', () {
    final group = Group(components: [
      CharacterClass('a'),
      CharacterClass('b'),
      CharacterClass('c'),
    ]);
    expect(group.pattern, '(?:abc)');
  });

  test('pattern component', () {
    final group = Group(components: [Regex('abc')]);
    expect(group.pattern, '(?:abc)');
  });
}
