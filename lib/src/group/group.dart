import 'package:meta/meta.dart';

import '../regex_component.dart';

class Group extends RegexComponent {
  final List<RegexComponent> components;
  final GroupBehavior behavior;

  const Group(
    this.components, {
    this.behavior = const GroupBehavior.nonCapture(),
  });

  @override
  String get pattern {
    final componentsPattern = components.map((e) => e.pattern).join();
    return '(${behavior.prefix}$componentsPattern)';
  }
}

abstract class GroupBehavior {
  final String prefix;

  @internal
  const GroupBehavior(this.prefix);

  const factory GroupBehavior.nonCapture() = NonCaptureGroupBehavior;

  const factory GroupBehavior.capture([String name]) = CaptureGroupBehavior;
}

class NonCaptureGroupBehavior extends GroupBehavior {
  const NonCaptureGroupBehavior() : super('?:');
}

class CaptureGroupBehavior extends GroupBehavior {
  final String? name;

  const CaptureGroupBehavior([this.name])
      : super(name != null ? '?<$name>' : '');
}

class LookaheadGroupBehavior extends GroupBehavior {
  const LookaheadGroupBehavior() : super('?=');
}

class NegativeLookaheadGroupBehavior extends GroupBehavior {
  const NegativeLookaheadGroupBehavior() : super('?!');
}
