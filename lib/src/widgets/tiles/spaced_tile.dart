import 'package:flutter/material.dart';
import 'package:storyflutter/src/models/organizers/organizer.dart';
import 'package:storyflutter/src/widgets/tiles/tile.dart';
import 'package:storyflutter/src/widgets/tiles/tile_spacer.dart';

class SpacedTile extends StatelessWidget {
  const SpacedTile({
    Key? key,
    required this.organizer,
    required this.level,
    required this.iconData,
    required this.iconColor,
    this.onClicked,
  }) : super(key: key);

  final int level;
  final Organizer organizer;
  final IconData iconData;
  final Color iconColor;
  final VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TileSpacer(level: level),
        Tile(
          iconData: iconData,
          iconColor: iconColor,
          organizer: organizer,
          onClicked: onClicked,
        ),
      ],
    );
  }
}
