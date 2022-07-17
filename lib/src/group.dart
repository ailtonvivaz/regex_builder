import '../regex_builder.dart';
import 'regex_component.dart';
import 'regex_modifier.dart';

class Group extends RegexModifier with RegexComponentPatterned {
  final List<RegexComponent> components;

  final GroupBehavior behavior;

  @override
  String get pattern {
    return '(${behavior.prefix}${components.pattern})';
  }

  const Group({
    required this.components,
    this.behavior = const GroupBehavior.nonCapture(),
  }) : super(const Regex(''));

  factory Group.pattern(String pattern) => Group(components: [Regex(pattern)]);
}

class GroupBehavior {
  final String prefix;

  const GroupBehavior._(this.prefix);

  factory GroupBehavior.capture([String? name]) =>
      GroupBehavior._(name != null ? '?<$name>' : '');

  const GroupBehavior.nonCapture() : this._('?:');

  const GroupBehavior.lookahead() : this._('?=');

  const GroupBehavior.negativeLookahead() : this._('?!');

  const GroupBehavior.lookbehind() : this._('?<=');

  const GroupBehavior.negativeLookbehind() : this._('?<!');
}
