import 'package:flutter/material.dart';
import 'package:marina/common/utils/colours.dart';
import 'package:marina/common/utils/text.dart';

Widget measureValueButton(int number, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: isSelected
          ? Colours.lightThemePrimaryColour
          : Colours.lightThemeGray2Colour,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        number.toString(),
        style: isSelected
            ? TextStyles.button.copyWith(color: Colours.lightThemeWhiteColour)
            : TextStyles.button,
      ),
    ),
  );
}
