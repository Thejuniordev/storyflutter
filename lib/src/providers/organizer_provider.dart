import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:storyflutter/src/models/models.dart';
import 'package:storyflutter/src/models/organizers/helpers/organizer_helper.dart';
import 'package:storyflutter/src/providers/organizer_state.dart';
import 'package:storyflutter/src/providers/provider.dart';
import 'package:storyflutter/src/repositories/selected_story_repository.dart';
import 'package:storyflutter/src/repositories/story_repository.dart';
import 'package:storyflutter/src/services/filter_service.dart';

class OrganizerBuilder extends StatefulWidget {
  const OrganizerBuilder({
    Key? key,
    required this.initialState,
    required this.child,
    required this.storyRepository,
    required this.selectedStoryRepository,
    required this.filterService,
  }) : super(key: key);

  final Widget child;
  final StoryRepository storyRepository;
  final OrganizerState initialState;
  final SelectedStoryRepository selectedStoryRepository;
  final FilterService filterService;

  @override
  _OrganizerBuilderState createState() => _OrganizerBuilderState();
}

class _OrganizerBuilderState extends State<OrganizerBuilder> {
  late OrganizerState state;
  late OrganizerProvider provider;
  @override
  void initState() {
    state = widget.initialState;
    setProvider();

    widget.selectedStoryRepository.getStream().forEach((Story? story) {
      provider.openStory(story);
    });

    super.initState();
  }

  void setProvider() {
    provider = OrganizerProvider(
      selectedStoryRepository: widget.selectedStoryRepository,
      storyRepository: widget.storyRepository,
      filterService: widget.filterService,
      state: state,
      onStateChanged: (OrganizerState state) {
        setState(() {
          this.state = state;
          setProvider();
        });
      },
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return provider;
  }
}

class OrganizerProvider extends Provider<OrganizerState> {
  const OrganizerProvider({
    required this.selectedStoryRepository,
    required this.storyRepository,
    required this.filterService,
    required OrganizerState state,
    required ValueChanged<OrganizerState> onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
          state: state,
          onStateChanged: onStateChanged,
          child: child,
          key: key,
        );

  final SelectedStoryRepository selectedStoryRepository;
  final StoryRepository storyRepository;
  final FilterService filterService;

  static OrganizerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OrganizerProvider>();
  }

  void openStory(Story? story) {
    if (story == null) {
      return;
    }
    var currentOrganizer = story.parent as ExpandableOrganizer?;
    while (currentOrganizer != null) {
      currentOrganizer.isExpanded = true;
      currentOrganizer = currentOrganizer.parent as ExpandableOrganizer?;
    }
  }

  void _updateFolders(List<Category> categories) {
    final oldFolders = FolderHelper.getAllFoldersFromCategories(
      state.allCategories,
    );
    final newFolders = FolderHelper.getAllFoldersFromCategories(
      categories,
    );
    final oldFolderMap = HashMap<String, Folder>.fromIterable(
      oldFolders,
      key: (dynamic k) => k.path as String,
      value: (dynamic v) => v as Folder,
    );

    for (final folder in newFolders) {
      final path = folder.path;
      if (oldFolderMap.containsKey(path)) {
        folder.isExpanded = oldFolderMap[path]!.isExpanded;
      }
    }
  }

  void _updateWidgets(List<Category> categories) {
    final oldWidgets = WidgetHelper.getAllWidgetElementsFromCategories(
      state.allCategories,
    );
    final newWidgets = WidgetHelper.getAllWidgetElementsFromCategories(
      categories,
    );
    final oldFolderMap = HashMap<String, WidgetElement>.fromIterable(
      oldWidgets,
      key: (dynamic k) => k.path as String,
      value: (dynamic v) => v as WidgetElement,
    );

    for (final widget in newWidgets) {
      final path = widget.path;
      if (oldFolderMap.containsKey(path)) {
        widget.isExpanded = oldFolderMap[path]!.isExpanded;
      }
    }
  }

  void update(List<Category> categories) {
    _updateFolders(categories);
    _updateWidgets(categories);
    emit(
      OrganizerState.unfiltered(categories: categories),
    );

    final stories = StoryHelper.getAllStoriesFromCategories(categories);
    storyRepository
      ..deleteAll()
      ..addAll(stories);
  }

  void resetFilter() {
    emit(
      OrganizerState.unfiltered(
        categories: state.allCategories,
      ),
    );
  }

  void filter(String searchTerm) {
    final categories = filterService.filter(
      searchTerm,
      state.allCategories,
    );

    emit(
      OrganizerState(
        allCategories: state.allCategories,
        filteredCategories: categories,
        searchTerm: searchTerm,
      ),
    );
  }

  @override
  void emit(OrganizerState state) {
    onStateChanged(state);
  }

  void toggleExpander(ExpandableOrganizer organizer) {
    organizer.isExpanded = !organizer.isExpanded;
    emit(
      OrganizerState(
        allCategories: state.allCategories,
        filteredCategories: state.filteredCategories,
        searchTerm: state.searchTerm,
      ),
    );
  }
}
