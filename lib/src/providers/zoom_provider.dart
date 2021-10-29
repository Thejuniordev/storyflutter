import 'package:flutter/cupertino.dart';
import 'package:storyflutter/src/providers/zoom_state.dart';

class ZoomBuilder extends StatefulWidget {
  const ZoomBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _ZoomBuilderState createState() => _ZoomBuilderState();
}

class _ZoomBuilderState extends State<ZoomBuilder> {
  ZoomState state = ZoomState.normal();

  @override
  Widget build(BuildContext context) {
    return ZoomProvider(
      state: state,
      onStateChanged: (ZoomState state) {
        setState(() {
          this.state = state;
        });
      },
      child: widget.child,
    );
  }
}

class ZoomProvider extends InheritedWidget {
  const ZoomProvider({
    required this.state,
    required this.onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
          child: child,
          key: key,
        );

  final ZoomState state;
  final ValueChanged<ZoomState> onStateChanged;
  double get levelChange => 0.25;

  static ZoomProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ZoomProvider>();
  }

  void zoomIn() {
    onStateChanged(
      ZoomState(
        zoomLevel: state.zoomLevel + levelChange,
      ),
    );
  }

  void setScale(double scale) {
    onStateChanged(
      ZoomState(
        zoomLevel: scale,
      ),
    );
  }

  void zoomOut() {
    onStateChanged(
      ZoomState(
        zoomLevel: (state.zoomLevel - levelChange).clamp(
          0.25,
          999,
        ),
      ),
    );
  }

  void resetToNormal() {
    onStateChanged(
      ZoomState.normal(),
    );
  }

  @override
  bool updateShouldNotify(covariant ZoomProvider oldWidget) {
    return oldWidget.state != state ||
        oldWidget.onStateChanged != onStateChanged;
  }
}
