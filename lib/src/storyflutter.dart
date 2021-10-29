import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:storyflutter/src/models/app_info.dart';

class Storyflutter extends StatefulWidget {
  final AppInfo appInfo;

  const Storyflutter({
    Key? key,
    required this.appInfo,
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
