import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storyflutter/src/constants/radii.dart';
import 'package:storyflutter/src/models/app_info.dart';
import 'package:storyflutter/src/models/organizers/organizers.dart';
import 'package:storyflutter/src/providers/theme_provider.dart';
import 'package:storyflutter/src/widgets/header.dart';
import 'package:storyflutter/src/widgets/search_bar.dart';
import 'package:storyflutter/src/widgets/tiles/category_tile.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({
    Key? key,
    required this.appInfo,
    required this.categories,
  }) : super(key: key);

  final AppInfo appInfo;
  final List<Category> categories;

  @override
  _NavigationPanelState createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  final ScrollController controller = ScrollController();
  Story? selectedComponent;

  final TextEditingController search = TextEditingController();
  String query = '';

  Widget _buildCategory(BuildContext context, int i) {
    final item = widget.categories[i];
    return CategoryTile(category: item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 50, maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            appInfo: widget.appInfo,
          ),
          const SizedBox(
            height: 16,
          ),
          SearchBar(
            theme: ThemeProvider.of(context)!.state,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: Radii.defaultRadius,
              ),
              padding: const EdgeInsets.all(16),
              child: Builder(
                builder: (context) {
                  return ListView.separated(
                    controller: controller,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.categories.length,
                    itemBuilder: _buildCategory,
                    padding: const EdgeInsets.only(bottom: 8),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
