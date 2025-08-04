import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';

class MAppTheme {
  static ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Jura',
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colours.lightThemePrimaryColour),
    ),
  );
}
