import 'package:storyflutter/src/repositories/memory_repository.dart';
import 'package:storyflutter/storyflutter.dart';

class StoryRepository extends MemoryRepository<Story> {
  StoryRepository({
    Map<String, Story>? initialConfiguration,
  }) : super(
          initialConfiguration: initialConfiguration,
        );
}
