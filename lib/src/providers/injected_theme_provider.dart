import 'package:flutter/material.dart';
import 'package:storyflutter/src/providers/injected_theme_state.dart';
import 'package:storyflutter/src/providers/provider.dart';

class InjectedThemeBuilder extends StatefulWidget {
  const InjectedThemeBuilder({
    Key? key,
    required this.child,
    this.lightTheme,
    this.darkTheme,
  }) : super(key: key);

  final Widget child;
  final ThemeData? lightTheme;
  final ThemeData? darkTheme;

  @override
  _InjectedThemeBuilderState createState() => _InjectedThemeBuilderState();
}

class _InjectedThemeBuilderState extends State<InjectedThemeBuilder> {
  late InjectedThemeState state;

  @override
  void initState() {
    state = InjectedThemeState(
      lightTheme: widget.lightTheme,
      darkTheme: widget.darkTheme,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InjectedThemeProvider(
      state: state,
      onStateChanged: (InjectedThemeState state) {
        setState(() {
          this.state = state;
        });
      },
      child: widget.child,
    );
  }
}

class InjectedThemeProvider extends Provider<InjectedThemeState> {
  const InjectedThemeProvider({
    required InjectedThemeState state,
    required ValueChanged<InjectedThemeState> onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
          state: state,
          onStateChanged: onStateChanged,
          child: child,
          key: key,
        );

  static InjectedThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InjectedThemeProvider>();
  }

  void themesChanged({
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) {
    emit(
      InjectedThemeState(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
