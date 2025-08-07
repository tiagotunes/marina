import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';
import 'package:marina/common/utils/themes/app_bar_theme.dart';
import 'package:marina/common/utils/themes/icon_button_theme.dart';
import 'package:marina/common/utils/themes/input_theme.dart';

class MAppTheme {
  static ThemeData lightThemeData = ThemeData(
    appBarTheme: MarinaAppBarTheme.lightAppBarTheme,
    brightness: Brightness.light,
    fontFamily: TextStyles.fontFamily,
    iconButtonTheme: MarinaIconButtonTheme.lighIconButtonTheme,
    inputDecorationTheme: InputTheme.lightInputTheme,
    scaffoldBackgroundColor: Colours.lightThemeWhiteColour,
  );
}
