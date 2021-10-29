import 'package:flutter/material.dart';
import 'package:storyflutter/src/constants/radii.dart';

import 'package:storyflutter/src/utils/utils.dart';
import 'package:storyflutter/src/widgets/controls_bar.dart';
import 'package:storyflutter/src/widgets/story_render.dart';

class Editor extends StatelessWidget {
  const Editor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ControlsBar(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: Radii.defaultRadius,
              color: context.colorScheme.surface,
            ),
            child: const StoryRender(),
          ),
        ),
      ],
    );
  }
}
