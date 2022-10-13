import 'character_set.dart';

class GroupCharacterSet extends CharacterSet {
  final List<CharacterSet> components;

  const GroupCharacterSet(this.components, {super.negate})
      : super.internal(requireBrackets: true);

  Iterable<CharacterSet> get _expandedComponents sync* {
    for (final component in components) {
      if (component is GroupCharacterSet) {
        if (component.negate) {
          print(
              'Negation is not supported in nested character sets and will be ignored.');
        }
        yield* component._expandedComponents;
      } else {
        yield component;
      }
    }
  }

  @override
  String get literalPattern =>
      _expandedComponents.map((c) => c.literalPattern).join();
}
