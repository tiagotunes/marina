import 'package:flutter/material.dart';
import 'package:marina/core/utils/core_utils.dart';

abstract class Colours {
  static const Color lightThemePrimaryColour = Color(0xFF008391);
  static const Color lightThemeSecondaryColour = Color(0xFFAB61DF);

  static const Color lightThemePrimaryTextColour = Color(0xFF000401);
  static const Color darkThemePrimaryTextColour = Color(0xFFE1E3E6);

  static const Color lightThemeWhiteColour = Color(0xFFFFFFFF);

  static Color lightThemeBackgroundColour = Color(0xFFFFFFFF);
  static Color darkThemeBackgroundColour = Color(0xFF27093A);

  static Color classicAdaptiveTextColour(BuildContext context) =>
      CoreUtils.adaptiveColour(
        context,
        lightModeColour: lightThemePrimaryTextColour,
        darkModeColour: darkThemePrimaryTextColour,
      );
}
