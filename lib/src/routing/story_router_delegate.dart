import 'package:flutter/material.dart';
import 'package:storyflutter/src/navigation/ui/navigation_panel.dart';
import 'package:storyflutter/src/providers/canvas_provider.dart';
import 'package:storyflutter/src/providers/canvas_state.dart';
import 'package:storyflutter/src/providers/organizer_provider.dart';
import 'package:storyflutter/src/routing/story_route_path.dart';
import 'package:storyflutter/src/styled_widgets/styled_scaffold.dart';
import 'package:storyflutter/src/widgets/wrapper.dart';

import 'package:storyflutter/storyflutter.dart';

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord>
        locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }
    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      results.add(exitingPageRoute);
    }
    return results;
  }
}

class StoryRouterDelegate extends RouterDelegate<StoryRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<StoryRoutePath> {
  StoryRouterDelegate({
    required this.appInfo,
    required this.canvasState,
  }) : navigatorKey = GlobalKey<NavigatorState>();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppInfo appInfo;
  final CanvasState canvasState;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      transitionDelegate: NoAnimationTransitionDelegate(),
      pages: [
        MaterialPage<dynamic>(
          key: ValueKey(currentConfiguration.path),
          child: StyledScaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Builder(builder: (context) {
                final state = OrganizerProvider.of(context)!.state;
                return Row(
                  children: [
                    NavigationPanel(
                      appInfo: appInfo,
                      categories: state.filteredCategories,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Expanded(
                      child: Editor(),
                    ),
                  ],
                );
              }),
            ),
          ),
        )
      ],
      onPopPage: (route, dynamic result) {
        if (!route.didPop(result)) {
          return false;
        }

        CanvasProvider.of(context)!.deselectStory();

        notifyListeners();

        return true;
      },
    );
  }

  @override
  StoryRoutePath get currentConfiguration => StoryRoutePath(
        path: canvasState.selectedStory == null
            ? '/'
            : '/stories/${canvasState.selectedStory!.path}',
      );

  @override
  Future<void> setNewRoutePath(StoryRoutePath configuration) async {}
}
