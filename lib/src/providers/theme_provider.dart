import 'package:flutter/material.dart';
import 'package:storyflutter/src/providers/provider.dart';

class ThemeBuilder extends StatefulWidget {
  const ThemeBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _ThemeBuilderState createState() => _ThemeBuilderState();
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  ThemeMode state = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      state: state,
      onStateChanged: (ThemeMode state) {
        setState(() {
          this.state = state;
        });
      },
      child: widget.child,
    );
  }
}

class ThemeProvider extends Provider<ThemeMode> {
  const ThemeProvider({
    required ThemeMode state,
    required ValueChanged<ThemeMode> onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
            state: state,
            onStateChanged: onStateChanged,
            child: child,
            key: key);

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  void toggleTheme() {
    switch (state) {
      case ThemeMode.light:
        emit(ThemeMode.dark);
        break;
      default:
        emit(ThemeMode.light);
    }
  }
}
