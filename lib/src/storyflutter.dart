import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:storyflutter/src/configure_non_web.dart'
    if (dart.library.html) 'package:storyflutter/src/configure_web.dart';
import 'package:storyflutter/src/models/app_info.dart';
import 'package:storyflutter/src/models/device.dart';

class Storyflutter extends StatefulWidget {
  final AppInfo appInfo;

  final List<Device> devices;

  const Storyflutter({
    Key? key,
    required this.appInfo,
    this.devices = const [
      Apple.iPhone7,
      Samsung.s21ultra,
    ],
  }) : super(key: key);
  @override
  _StoryflutterState createState() => _StoryflutterState();
}

class _StoryflutterState extends State<Storyflutter> {
  late BuildContext contextWithProviders;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
