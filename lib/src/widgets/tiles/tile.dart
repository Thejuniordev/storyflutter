import 'package:flutter/material.dart';
import 'package:storyflutter/src/constants/radii.dart';
import 'package:storyflutter/src/models/organizers/organizer.dart';
import 'package:storyflutter/src/providers/canvas_provider.dart';
import 'package:storyflutter/src/utils/styles.dart';
import 'package:storyflutter/src/utils/utils.dart';

class Tile extends StatefulWidget {
  const Tile({
    Key? key,
    required this.iconData,
    required this.iconColor,
    required this.organizer,
    this.onClicked,
  }) : super(key: key);

  final IconData iconData;
  final Color iconColor;
  final Organizer organizer;
  final VoidCallback? onClicked;

  static const double spacing = 8;

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool hovered = false;

  Widget _buildTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Row(
        children: [
          Icon(
            widget.iconData,
            color: hovered ? context.colorScheme.onPrimary : widget.iconColor,
            size: 16,
          ),
          const SizedBox(
            width: Tile.spacing,
          ),
          Text(widget.organizer.name),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = CanvasProvider.of(context)!.state;
    final isSelected = state.selectedStory == widget.organizer;

    return GestureDetector(
      onTap: () {
        widget.onClicked?.call();
      },
      child: MouseRegion(
        onEnter: (e) {
          setState(() => hovered = true);
        },
        onExit: (e) {
          setState(() => hovered = false);
        },
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: hovered || isSelected
                ? Styles.getHighlightColor(context)
                : null,
            borderRadius: Radii.defaultRadius,
          ),
          duration: const Duration(milliseconds: 100),
          child: _buildTile(context),
        ),
      ),
    );
  }
}
