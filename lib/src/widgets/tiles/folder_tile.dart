import 'package:flutter/material.dart';

import 'package:storyflutter/src/models/organizers/organizers.dart';
import 'package:storyflutter/src/providers/organizer_provider.dart';

import 'package:storyflutter/src/utils/utils.dart';
import 'package:storyflutter/src/widgets/tiles/spaced_tile.dart';
import 'package:storyflutter/src/widgets/tiles/tile_helper_methods.dart';

class FolderTile extends StatefulWidget {
  const FolderTile({
    Key? key,
    required this.folder,
    required this.level,
  }) : super(key: key);

  final Folder folder;
  final int level;

  @override
  _FolderTileState createState() => _FolderTileState();
}

class _FolderTileState extends State<FolderTile> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final folder = widget.folder;
    final isExpanded = widget.folder.isExpanded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpacedTile(
          level: widget.level,
          organizer: widget.folder,
          iconData: isExpanded ? Icons.folder_open : Icons.folder,
          iconColor: context.colorScheme.primary,
          onClicked: () {
            setState(() {
              OrganizerProvider.of(context)!.toggleExpander(widget.folder);
            });
          },
        ),
        if (isExpanded)
          ...buildFolders(
            folders: folder.folders,
            currentLevel: widget.level + 1,
          ),
        if (isExpanded)
          ...buildWidgets(
            widgets: folder.widgets,
            currentLevel: widget.level + 1,
          )
      ],
    );
  }
}
