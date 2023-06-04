import 'regex_component.dart';

class RegexBuilder implements RegExp {
  // Rest of code...
  
  String build() {
    final buffer = StringBuffer();
    for (final component in components) {
      if (component is LookAhead) {
        buffer.write(component.pattern);
      } else {
        buffer.write(component.build());  
      }
    }
    return buffer.toString();
  } 
}
