import 'package:regex_builder/regex_builder.dart';
import 'package:test/test.dart';

void main() {
  test('one component', () {
    final group = Group([Literal('a')]);
    expect(group.pattern, '(?:a)');
  });

  test('multiple components', () {
    final group = Group([
      Literal('a'),
      Literal('b'),
      Literal('c'),
    ]);
    expect(group.pattern, '(?:abc)');
  });

  test('pattern component', () {
    final group = Group([Literal('abc')]);
    expect(group.pattern, '(?:abc)');
  });
}
