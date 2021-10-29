import 'package:flutter/material.dart';
import 'package:storyflutter/storyflutter.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Text('hello world'),
    );
  }
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

void main() {
  runApp(const HotReload());
}
