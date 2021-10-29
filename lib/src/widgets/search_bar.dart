import 'package:flutter/material.dart';
import 'package:storyflutter/src/constants/radii.dart';
import 'package:storyflutter/src/providers/organizer_provider.dart';
import 'package:storyflutter/src/utils/utils.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.theme,
    this.organizerProvider,
  }) : super(key: key);

  final ThemeMode theme;
  final OrganizerProvider? organizerProvider;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();

  OrganizerProvider _getProvider() {
    return widget.organizerProvider ?? OrganizerProvider.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = widget.theme == ThemeMode.light
        ? Styles.lightSurface
        : Styles.darkSurface;
    final onFillColor = widget.theme == ThemeMode.light
        ? Styles.onLightSurface
        : Styles.onDarkSurface;

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: Radii.defaultRadius,
    );

    return TextField(
      key: Key('$SearchBar.$TextField'),
      controller: controller,
      cursorWidth: 3,
      cursorColor: onFillColor,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'search',
        suffixIcon:
            controller.text.isNotEmpty ? _buildCancelSearchButton() : null,
        filled: true,
        fillColor: fillColor,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
      onChanged: (value) {
        setState(() {});
        _getProvider().filter(value);
      },
    );
  }

  Widget _buildCancelSearchButton() {
    return IconButton(
      key: Key('$SearchBar.CancelSearchButton'),
      icon: const Icon(Icons.close),
      splashRadius: 20,
      onPressed: () {
        setState(
          () {
            controller = TextEditingController();
          },
        );

        _getProvider().resetFilter();
      },
    );
  }
}
