import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:storyflutter/src/constants/constants.dart';
import 'package:storyflutter/src/widgets/device_bar.dart';
import 'package:storyflutter/src/widgets/theme_handle.dart';
import 'package:storyflutter/src/widgets/zoom_handle.dart';

class ControlsBar extends StatelessWidget {
  const ControlsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.controlBarHeight,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ZoomHandle(),
                  SizedBox(
                    width: 40,
                  ),
                  ThemeHandle(),
                  SizedBox(
                    width: 40,
                  ),
                  DeviceBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
