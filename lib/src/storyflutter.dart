import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:storyflutter/src/configure_non_web.dart'
    if (dart.library.html) 'package:storyflutter/src/configure_web.dart';
import 'package:storyflutter/src/models/app_info.dart';
import 'package:storyflutter/src/models/device.dart';
import 'package:storyflutter/src/models/organizers/helpers/organizer_helper.dart';
import 'package:storyflutter/src/models/organizers/organizers.dart';
import 'package:storyflutter/src/providers/canvas_provider.dart';
import 'package:storyflutter/src/providers/device_provider.dart';
import 'package:storyflutter/src/providers/injected_theme_provider.dart';
import 'package:storyflutter/src/providers/organizer_provider.dart';
import 'package:storyflutter/src/providers/organizer_state.dart';
import 'package:storyflutter/src/providers/theme_provider.dart';
import 'package:storyflutter/src/providers/zoom_provider.dart';
import 'package:storyflutter/src/repositories/selected_story_repository.dart';
import 'package:storyflutter/src/repositories/story_repository.dart';
import 'package:storyflutter/src/routing/route_information_parser.dart';
import 'package:storyflutter/src/routing/story_router_delegate.dart';
import 'package:storyflutter/src/services/filter_service.dart';
import 'package:storyflutter/src/utils/utils.dart';

class Storyflutter extends StatefulWidget {
  const Storyflutter({
    Key? key,
    required this.categories,
    this.devices = const [
      Apple.iPhone7,
      Samsung.s21ultra,
    ],
    required this.appInfo,
    this.lightTheme,
    this.darkTheme,
  }) : super(key: key);

  /// Categories which host Folders and WidgetElements.
  /// This can be used to organize the structure of the Storyflutter on a large
  /// scale.
  final List<Category> categories;

  /// The devices on which Stories are previewed.
  final List<Device> devices;

  /// Information about the app that is catalogued in the Storyflutter.
  final AppInfo appInfo;

  /// The `ThemeData` that is shown when the light theme is active.
  final ThemeData? lightTheme;

  /// The `ThemeData` that is shown when the dark theme is active.
  final ThemeData? darkTheme;

  @override
  _StoryflutterState createState() => _StoryflutterState();
}

class _StoryflutterState extends State<Storyflutter> {
  // TODO ugly hack
  late BuildContext contextWithProviders;

  SelectedStoryRepository selectedStoryRepository = SelectedStoryRepository();
  StoryRepository storyRepository = StoryRepository();

  @override
  void initState() {
    configureApp();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Storyflutter oldWidget) {
    // TODO remove this and put into the Builders
    OrganizerProvider.of(contextWithProviders)!.update(widget.categories);
    DeviceProvider.of(contextWithProviders)!.update(widget.devices);
    InjectedThemeProvider.of(contextWithProviders)!.themesChanged(
      lightTheme: widget.lightTheme,
      darkTheme: widget.darkTheme,
    );

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return OrganizerBuilder(
      initialState: OrganizerState.unfiltered(
        categories: widget.categories,
      ),
      storyRepository: storyRepository,
      selectedStoryRepository: selectedStoryRepository,
      filterService: const FilterService(),
      child: CanvasBuilder(
        selectedStoryRepository: selectedStoryRepository,
        storyRepository: storyRepository,
        child: ZoomBuilder(
          child: ThemeBuilder(
            child: DeviceBuilder(
              availableDevices: widget.devices,
              currentDevice: widget.devices.first,
              child: InjectedThemeBuilder(
                lightTheme: widget.lightTheme,
                darkTheme: widget.darkTheme,
                child: Builder(builder: (context) {
                  contextWithProviders = context;
                  final canvasState = CanvasProvider.of(context)!.state;
                  final storiesState = OrganizerProvider.of(context)!.state;
                  final themeMode = ThemeProvider.of(context)!.state;

                  return MaterialApp.router(
                    routeInformationParser: StoryRouteInformationParser(
                      onRoute: (path) {
                        final stories = StoryHelper.getAllStoriesFromCategories(
                          storiesState.allCategories,
                        );
                        final selectedStory =
                            selectStoryFromPath(path, stories);
                        CanvasProvider.of(context)!.selectStory(selectedStory);
                      },
                    ),
                    routerDelegate: StoryRouterDelegate(
                      canvasState: canvasState,
                      appInfo: widget.appInfo,
                    ),
                    title: widget.appInfo.name,
                    debugShowCheckedModeBanner: false,
                    themeMode: themeMode,
                    darkTheme: Styles.darkTheme,
                    theme: Styles.lightTheme,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Story? selectStoryFromPath(
    String? path,
    List<Story> stories,
  ) {
    final storyPath = path?.replaceFirst('/stories/', '') ?? '';
    Story? story;
    for (final element in stories) {
      if (element.path == storyPath) {
        story = element;
      }
    }
    return story;
  }
}
