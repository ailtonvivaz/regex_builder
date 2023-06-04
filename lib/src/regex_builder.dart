import 'regex_component.dart';

class RegexBuilder implements RegExp {
  // ...

  String build(RegexComponent component) {
    if (component is LookAhead) {
      return '${component.pattern}';
    }
    if (component is Group) {
      return '(${buildGroup(component)})';
    }
    return component.pattern;
  }

  String buildGroup(Group group) {
    return group.components.map(build).join('');
  }  

  // ...
}
