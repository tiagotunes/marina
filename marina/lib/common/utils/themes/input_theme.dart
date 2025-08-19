import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';

class InputTheme {
  static InputDecorationTheme lightInputTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colours.lightThemeGray2Colour),
    ),
    filled: true,
    fillColor: Colours.lightThemeGray1Colour,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colours.lightThemeGray2Colour),
    ),
    hintStyle: TextStyles.body2,
    labelStyle: TextStyles.body2,
    prefixIconColor: Colours.lightThemePrimaryColour,
    suffixIconColor: Colours.lightThemePrimaryColour,
  );
}
