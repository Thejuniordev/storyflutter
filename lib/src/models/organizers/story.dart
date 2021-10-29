import 'package:flutter/material.dart';

import 'package:storyflutter/src/models/model.dart';
import 'package:storyflutter/src/models/organizers/organizer.dart';

/// Stories represent a specific configuration of a widget.
class Story extends Organizer implements Model {
  Story({required String name, required this.builder}) : super(name);

  factory Story.center({
    required String name,
    required Widget child,
  }) {
    return Story(
      name: name,
      builder: (_) => Center(child: child),
    );
  }

  factory Story.child({
    required String name,
    required Widget child,
  }) {
    return Story(
      name: name,
      builder: (_) => child,
    );
  }

  final Widget Function(BuildContext) builder;

  @override
  String get id => path;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Story && other.builder == builder;
  }

  @override
  int get hashCode => builder.hashCode;
}
