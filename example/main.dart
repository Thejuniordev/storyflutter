import 'package:flutter/material.dart';
import 'package:storyflutter/src/models/models.dart';
import 'package:storyflutter/src/models/organizers/category.dart';
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
    return Storyflutter(
      categories: [
        Category(
          name: 'widgets',
          widgets: [
            WidgetElement(
              name: '$CustomWidget',
              stories: [
                Story(
                  name: 'Default',
                  builder: (context) => const CustomWidget(),
                ),
              ],
            ),
          ],
          folders: [
            Folder(
              name: 'Texts',
              widgets: [
                WidgetElement(
                  name: 'Normal Text',
                  stories: [
                    Story(
                      name: 'Default',
                      builder: (context) => const Text(
                        'The brown fox ...',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      appInfo: AppInfo(
        name: 'Storybook Flutter',
      ),
    );
  }
}

void main() {
  runApp(const HotReload());
}
