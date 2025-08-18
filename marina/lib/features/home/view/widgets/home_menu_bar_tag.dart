import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';

Widget homeMenuBarTag({String text = "", bool selected = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: selected
          ? Colours.lightThemePrimaryColour
          : Colours.lightThemeGray1Colour,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      text,
      style: selected
          ? TextStyles.tagline.copyWith(color: Colours.lightThemeWhiteColour)
          : TextStyles.tagline.copyWith(color: Colours.lightThemeGray2Colour),
    ),
  );
}
