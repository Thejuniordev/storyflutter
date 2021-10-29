import 'package:flutter/material.dart';
import 'package:storyflutter/src/models/organizers/organizers.dart';
import 'package:storyflutter/src/utils/utils.dart';
import 'package:storyflutter/src/widgets/tiles/tile_helper_methods.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            category.name,
            style: context.textTheme.subtitle2,
          ),
        ),
        ...buildFolders(
          folders: category.folders,
          currentLevel: 0,
        ),
        ...buildWidgets(
          widgets: category.widgets,
          currentLevel: 0,
        ),
      ],
    );
  }
}
