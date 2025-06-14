import 'package:flutter/material.dart';
import 'package:marina/core/res/styles/colours.dart';
import 'package:marina/core/utils/core_utils.dart';

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: ColoredBox(
        color: CoreUtils.adaptiveColour(
          context,
          lightModeColour: Colors.white,
          darkModeColour: Colours.darkThemeBgdDark,
        ),
        child: const SizedBox(height: 1, width: double.infinity),
      ),
    );
  }

  @override
  Size get preferredSize => Size.zero;
}
