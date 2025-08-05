import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

class MarinaIconButtonTheme {
  static IconButtonThemeData lighIconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      backgroundColor: Colours.lightThemePrimaryColour,
      foregroundColor: Colours.lightThemeWhiteColour,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
    ),
  );
}
