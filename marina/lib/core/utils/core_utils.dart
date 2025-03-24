import 'package:flutter/cupertino.dart';

abstract class CoreUtils {
  const CoreUtils();

  static Color adaptiveColour(
    BuildContext context, {
    required Color lightModeColour,
    required Color darkModeColour,
  }) {
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark
        ? darkModeColour
        : lightModeColour;
  }
}
