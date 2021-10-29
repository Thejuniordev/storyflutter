import 'package:storyflutter/src/models/organizers/helpers/organizer_helper.dart';
import 'package:storyflutter/src/models/organizers/organizers.dart';

/// Helper to obtain all Stories in the navigation tree.
class StoryHelper {
  static List<Story> getAllStoriesFromCategories(List<Category> categories) {
    final widgets = WidgetHelper.getAllWidgetElementsFromCategories(
      categories,
    );

    final stories = List<Story>.empty(growable: true);
    for (final widget in widgets) {
      stories.addAll(widget.stories);
    }

    return stories;
  }
}
